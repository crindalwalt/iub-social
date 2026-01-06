import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iub_social/Ali%20raza/Views/alihome.dart';
import 'package:iub_social/Ali%20raza/Views/myauthwrapper.dart';
import 'package:iub_social/Ali%20raza/Views/mylogin.dart';
import 'package:iub_social/Ali%20raza/provider/myauthentication_provider.dart';
import 'package:iub_social/Ali%20raza/provider/mypostprovider.dart';
import 'package:iub_social/firebase_options.dart';
import 'package:iub_social/providers/authentication_provider.dart';
import 'package:iub_social/providers/connection_provider.dart';
import 'package:iub_social/providers/post_provider.dart';
import 'package:iub_social/views/screens/auth/login.dart';
import 'package:provider/provider.dart';
import 'utils/app_colors.dart';
import 'views/common/main_navigation.dart';
import 'views/screens/onboarding/onboarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set system UI overlay styleP
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.primaryNavy,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.pureWhite,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // runApp( SocialApp());
  runApp(IUBSocialApp());
}

class IUBSocialApp extends StatelessWidget {
  const IUBSocialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => PostProvider1()),
        ChangeNotifierProvider(create: (_) => ConnectionProvider()),
      ],
      child: MaterialApp(
        title: 'IUB Social',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.primaryNavy,
          scaffoldBackgroundColor: AppColors.offWhite,
          fontFamily: 'Roboto',
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primaryNavy,
            primary: AppColors.primaryNavy,
            secondary: AppColors.accentNavy,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.primaryNavy,
            elevation: 0,
            iconTheme: IconThemeData(color: AppColors.pureWhite),
            titleTextStyle: TextStyle(
              color: AppColors.pureWhite,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentNavy,
              foregroundColor: AppColors.pureWhite,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        home: const AuthWrapper(),
      ),
    );
  }
}

/// AuthWrapper handles authentication state and shows appropriate screen
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProvider>(
      builder: (context, authProvider, child) {
        // If user is logged in and email is verified, show main navigation
        if (authProvider.isAuthenticated && authProvider.isEmailVerified) {
          return const MainNavigation();
        }
        // Otherwise show onboarding/login flow
        return const OnboardingScreen();
      },
    );
  }
}

// class SocialApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (context) => AuthenticationProvider1()),
//         ChangeNotifierProvider(create: (context) => Mypostprovider()),
//       ],
//       child: MaterialApp(
//         title: "Social App",
//         debugShowCheckedModeBanner: false,
//         home: AuthWrapper1(),
//       ),
//     );
//   }
// }
