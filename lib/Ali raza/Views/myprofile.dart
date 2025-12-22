import 'package:flutter/material.dart';
import 'package:iub_social/Ali%20raza/Views/settingscreen.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Color primaryBlue = const Color(0xFF007BFF);
  final Color lightBlue = const Color(0xFFEAF4FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlue,
      appBar: AppBar(
       
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Color(0xFF007BFF),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
        actions: [
          // ✅ Settings Button
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black87),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Cover area with gradient background
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        primaryBlue.withOpacity(0.9),
                        primaryBlue.withOpacity(0.6),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -50,
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: primaryBlue,
                      child: const Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),

            // User name and bio
            const Text(
              "Ali Raza",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Digital Creator | Tech Enthusiast 💻",
              style: TextStyle(fontSize: 15, color: Colors.black54),
            ),
            const SizedBox(height: 15),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildButton("Add Story", Icons.add_circle_outline),
                const SizedBox(width: 10),
                _buildButton("Edit Profile", Icons.edit_outlined),
              ],
            ),
            const SizedBox(height: 20),

            // About section
            _buildSectionTitle("About"),
            _buildInfoRow(
              Icons.location_on_outlined,
              "Lives in Lahore, Pakistan",
            ),
            _buildInfoRow(
              Icons.school_outlined,
              "Studied at Virtual University",
            ),
            _buildInfoRow(
              Icons.work_outline,
              "Works at Freelance Digital Marketer",
            ),
            _buildInfoRow(Icons.favorite_border, "Single"),
            const SizedBox(height: 15),

            // Friends section
            _buildSectionTitle("Friends"),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: primaryBlue.withOpacity(0.2),
                          child: const Icon(
                            Icons.person,
                            color: Color(0xFF007BFF),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Friend ${index + 1}",
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Posts section
            _buildSectionTitle("Your Posts"),
            _buildPostCard("Enjoying a sunny day 🌞"),
            _buildPostCard("Just finished a great project!"),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsOption(IconData icon, String title, {Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.black87),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: color ?? Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  // Helper widgets
  Widget _buildButton(String text, IconData icon) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 20),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: Colors.black54, size: 22),
          const SizedBox(width: 10),
          Text(
            info,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildPostCard(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          ListTile(
            leading: CircleAvatar(
              backgroundColor: primaryBlue,
              child: const Icon(Icons.person, color: Colors.white),
            ),
            title: const Text(
              "Ali Raza",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            subtitle: const Text("1 hr ago"),
            trailing: const Icon(Icons.more_horiz),
          ),
          // Post text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Text(
              text,
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ),
          // Placeholder box for image
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              color: lightBlue,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(12),
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.image_outlined,
                color: Colors.black38,
                size: 60,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
