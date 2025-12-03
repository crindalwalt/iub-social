import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/authentication_provider.dart';
import '../../../utils/app_colors.dart';
import '../../common/main_navigation.dart';
import 'login.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String email;

  const EmailVerificationScreen({super.key, required this.email});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  Timer? _timer;
  bool _canResend = true;
  int _resendCountdown = 0;

  @override
  void initState() {
    super.initState();
    // Send verification email when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sendVerificationEmail();
    });
    // Start periodic check for email verification
    _startVerificationCheck();
  }

  void _startVerificationCheck() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      final authProvider = Provider.of<AuthenticationProvider>(
        context,
        listen: false,
      );
      final isVerified = await authProvider.checkEmailVerified();
      if (isVerified && mounted) {
        timer.cancel();
        _showSnackBar('Email verified successfully!');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainNavigation()),
        );
      }
    });
  }

  Future<void> _sendVerificationEmail() async {
    if (!_canResend) return;

    final authProvider = Provider.of<AuthenticationProvider>(
      context,
      listen: false,
    );
    final success = await authProvider.sendEmailVerification();

    if (success) {
      _showSnackBar('Verification email sent!');
      _startResendCountdown();
    } else if (authProvider.errorMessage != null) {
      _showSnackBar(authProvider.errorMessage!, isError: true);
    }
  }

  void _startResendCountdown() {
    setState(() {
      _canResend = false;
      _resendCountdown = 60;
    });

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCountdown > 0) {
        setState(() {
          _resendCountdown--;
        });
      } else {
        timer.cancel();
        setState(() {
          _canResend = true;
        });
      }
    });
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? AppColors.dangerRed : AppColors.successGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Future<void> _handleCheckVerification() async {
    final authProvider = Provider.of<AuthenticationProvider>(
      context,
      listen: false,
    );
    final isVerified = await authProvider.checkEmailVerified();

    if (isVerified && mounted) {
      _showSnackBar('Email verified successfully!');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainNavigation()),
      );
    } else {
      _showSnackBar(
        'Email not verified yet. Please check your inbox.',
        isError: true,
      );
    }
  }

  void _handleChangeEmail() async {
    final authProvider = Provider.of<AuthenticationProvider>(
      context,
      listen: false,
    );
    await authProvider.signOut();
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryNavy),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                // Icon
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: AppColors.accentNavy.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.mark_email_unread_outlined,
                      size: 60,
                      color: AppColors.accentNavy,
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Title
                const Text(
                  'Verify Your Email',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryNavy,
                  ),
                ),

                const SizedBox(height: 12),

                // Description
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.darkGray,
                      height: 1.5,
                    ),
                    children: [
                      const TextSpan(text: 'We sent a verification link to\n'),
                      TextSpan(
                        text: widget.email,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryNavy,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Instructions
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.offWhite,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.lightGray),
                  ),
                  child: Column(
                    children: [
                      _buildStep(
                        number: '1',
                        text: 'Open your email inbox',
                        icon: Icons.inbox_outlined,
                      ),
                      const SizedBox(height: 16),
                      _buildStep(
                        number: '2',
                        text: 'Click the verification link',
                        icon: Icons.link,
                      ),
                      const SizedBox(height: 16),
                      _buildStep(
                        number: '3',
                        text: 'Come back here and continue',
                        icon: Icons.check_circle_outline,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Resend Code
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Didn't receive the email? ",
                      style: TextStyle(fontSize: 14, color: AppColors.darkGray),
                    ),
                    TextButton(
                      onPressed: _canResend ? _sendVerificationEmail : null,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        _canResend
                            ? 'Resend'
                            : 'Resend in ${_resendCountdown}s',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: _canResend
                              ? AppColors.accentNavy
                              : AppColors.mediumGray,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Verify Button
                Consumer<AuthenticationProvider>(
                  builder: (context, authProvider, child) {
                    return SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: authProvider.isLoading
                            ? null
                            : _handleCheckVerification,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentNavy,
                          foregroundColor: AppColors.pureWhite,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: authProvider.isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: AppColors.pureWhite,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : const Text(
                                'I\'ve Verified My Email',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 24),

                // Change Email
                TextButton(
                  onPressed: _handleChangeEmail,
                  child: const Text(
                    'Use a Different Email',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkGray,
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Info Box
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.offWhite,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.lightGray),
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.info_outline,
                        color: AppColors.accentNavy,
                        size: 24,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Check your spam folder if you don\'t see the email in your inbox.',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.darkGray,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStep({
    required String number,
    required String text,
    required IconData icon,
  }) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.accentNavy,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                color: AppColors.pureWhite,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Icon(icon, color: AppColors.accentNavy, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14, color: AppColors.primaryNavy),
          ),
        ),
      ],
    );
  }
}
