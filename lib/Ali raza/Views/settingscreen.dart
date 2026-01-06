import 'package:flutter/material.dart';
import 'package:iub_social/Ali%20raza/Views/mylogin.dart';
import 'package:iub_social/Ali%20raza/provider/myauthentication_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final Color primaryBlue = const Color(0xFF007BFF);
  final Color lightBlue = const Color(0xFFEAF4FF);

  bool isDarkMode = false;
  bool notificationsEnabled = true;
  bool emailVerified = true; // You can fetch this from backend later

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthenticationProvider1>(context);
    if (auth.user == null) {
      print("user is null,......");
    }

    final userId = auth.user?.uid;
    final userEmail = auth.user?.email ?? "";
    return Scaffold(
      backgroundColor: lightBlue,
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(
            color: Color(0xFF007BFF),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 👤 Profile Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: Color(0xFF007BFF),
                    child: Icon(Icons.person, color: Colors.white, size: 40),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (userId != null)
                          FutureBuilder<String?>(
                            future: auth.getUserNameFromId(userId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                );
                              }
                              final username = snapshot.data ?? "Unknown User";
                              return Text(
                                username,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              );
                            },
                          )
                        else
                          const Text(
                            "Not logged in",
                            style: TextStyle(fontSize: 18, color: Colors.red),
                          ),
                        const SizedBox(height: 4),
                        Text(
                          userEmail,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(
                              emailVerified
                                  ? Icons.verified_rounded
                                  : Icons.error_outline_rounded,
                              color: emailVerified ? Colors.green : Colors.red,
                              size: 18,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              emailVerified
                                  ? "Email Verified"
                                  : "Email Not Verified",
                              style: TextStyle(
                                color: emailVerified
                                    ? Colors.green
                                    : Colors.redAccent,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.black54),
                    onPressed: () {
                      // Navigate to Edit Profile screen (future)
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // 🌙 Theme & Notifications
            _buildSectionTitle("Preferences"),
            _buildSwitchTile(
              title: "Dark Mode",
              icon: Icons.dark_mode_outlined,
              value: isDarkMode,
              onChanged: (val) {
                setState(() => isDarkMode = val);
                // TODO: Add Theme change logic
              },
            ),
            _buildSwitchTile(
              title: "Notifications",
              icon: Icons.notifications_active_outlined,
              value: notificationsEnabled,
              onChanged: (val) {
                setState(() => notificationsEnabled = val);
              },
            ),

            const SizedBox(height: 20),

            // 🔒 Privacy & Account
            _buildSectionTitle("Account"),
            _buildOptionTile(
              title: "Privacy Settings",
              icon: Icons.lock_outline,
              onTap: () {},
            ),
            _buildOptionTile(
              title: "Security",
              icon: Icons.security_outlined,
              onTap: () {},
            ),
            _buildOptionTile(
              title: "Language",
              icon: Icons.language_outlined,
              onTap: () {},
            ),

            const SizedBox(height: 20),

            // ⚙️ General
            _buildSectionTitle("General"),
            _buildOptionTile(
              title: "Help & Support",
              icon: Icons.help_outline,
              onTap: () {},
            ),
            _buildOptionTile(
              title: "About App",
              icon: Icons.info_outline,
              onTap: () {},
            ),

            const SizedBox(height: 30),

            // 🚪 Logout
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  _showLogoutDialog(context);
                  auth.logoutFromAccount();
                },
                icon: const Icon(Icons.logout),
                label: const Text("Logout"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Section title widget
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  // Option ListTile
  Widget _buildOptionTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: primaryBlue),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
      tileColor: Colors.white,
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  // Switch tile for toggles
  Widget _buildSwitchTile({
    required String title,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      activeColor: primaryBlue,
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      secondary: Icon(icon, color: primaryBlue),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
      value: value,
      onChanged: onChanged,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final auth = Provider.of<AuthenticationProvider1>(context, listen: false);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text("Logout"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              Navigator.pop(context); // close the dialog first
              await auth.logoutFromAccount(); // ✅ sign out properly
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Logged out successfully"),
                    backgroundColor: Colors.green,
                  ),
                );

                // ✅ Navigate back to login screen and remove all previous routes
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen1()),
                  (route) => false,
                );
              }
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }
}
