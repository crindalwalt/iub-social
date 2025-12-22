import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:iub_social/Ali%20raza/Views/mypost.dart';
import 'package:iub_social/Ali%20raza/Views/myprofile.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final Color primaryBlue = const Color(0xFF007BFF);
  final Color lightBlue = const Color(0xFFEAF4FF);
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlue,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "SocialApp",
          style: TextStyle(
            color: Color(0xFF007BFF),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded, color: Colors.black87),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Colors.black87,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Post box
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      child: Expanded(
                        child: GestureDetector(
                          child: TextField(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CreatePostScreen(),
                                ),
                              );
                            },
                            decoration: InputDecoration(
                              hintText: "What's on your mind?",
                              hintStyle: const TextStyle(color: Colors.black54),
                              filled: true,
                              fillColor: const Color(0xFFF3F6FA),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Story Section
            Container(
              height: 120,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: primaryBlue.withOpacity(0.2),
                          child: const Icon(
                            Icons.person,
                            color: Color(0xFF007BFF),
                            size: 40,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "User ${index + 1}",
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
            const SizedBox(height: 8),

            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Aliposts")
                  .orderBy("createdAt", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      'No posts available',
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }

                final data = snapshot.data!.docs;
                return // Posts Feed
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {

                    final postdata=data[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: Color(0xFF007BFF),
                              child: Icon(Icons.person, color: Colors.white),
                            ),
                            title: Text(
                              "User ${index + 1}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            subtitle: const Text("2 hrs ago"),
                            trailing: const Icon(Icons.more_horiz),
                          ),

                          // Post Text
                           Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 8,
                            ),
                            child: Text(
                              postdata["postText"]!,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black87,
                              ),
                            ),
                          ),

                          // Post Image (placeholder)
                          Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(color: lightBlue),
                            child:Image.network(postdata["postImage"]!,fit: BoxFit.cover,)
                          ),

                          // Action Row
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildAction(
                                  Icons.thumb_up_alt_outlined,
                                  "Like",
                                ),
                                _buildAction(
                                  Icons.mode_comment_outlined,
                                  "Comment",
                                ),
                                _buildAction(Icons.share_outlined, "Share"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for post actions
  Widget _buildAction(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: Colors.black54, size: 22),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(color: Colors.black54, fontSize: 15),
        ),
      ],
    );
  }
}
