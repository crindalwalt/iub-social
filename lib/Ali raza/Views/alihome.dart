import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:iub_social/Ali%20raza/Views/mypost.dart';
import 'package:iub_social/Ali%20raza/Views/myprofile.dart';
import 'package:provider/provider.dart';
import 'package:iub_social/Ali%20raza/provider/mypostprovider.dart';
import 'package:iub_social/Ali%20raza/provider/myauthentication_provider.dart';
import 'package:intl/intl.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  // Controller and key for comment form
  final TextEditingController _commentController = TextEditingController();
  final GlobalKey<FormState> _commentFormKey = GlobalKey<FormState>();
  final Color primaryBlue = const Color(0xFF007BFF);
  final Color lightBlue = const Color(0xFFEAF4FF);
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationProvider1>(context);
    final postProvider = Provider.of<Mypostprovider>(context);
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
                    final postdata = data[index];
                    final postId = postdata.id;
                    final userId = authProvider.user?.uid ?? "";
                    final Timestamp? createdAt = postdata["createdAt"];
                    String timeAgo = "";
                    if (createdAt != null) {
                      final now = DateTime.now();
                      final postTime = createdAt.toDate();
                      final diff = now.difference(postTime);
                      if (diff.inSeconds < 60) {
                        timeAgo = "just now";
                      } else if (diff.inMinutes < 60) {
                        timeAgo = "${diff.inMinutes} min ago";
                      } else if (diff.inHours < 24) {
                        timeAgo = "${diff.inHours} hrs ago";
                      } else {
                        timeAgo = DateFormat('MMM d, yyyy').format(postTime);
                      }
                    }
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
                            title: FutureBuilder<DocumentSnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection("myusers")
                                  .doc(postdata["userId"])
                                  .get(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Text(
                                    "Loading...",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  );
                                }
                                if (!snapshot.hasData ||
                                    !snapshot.data!.exists) {
                                  return const Text(
                                    "Unknown User",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  );
                                }
                                final userData =
                                    snapshot.data!.data()
                                        as Map<String, dynamic>?;
                                final name =
                                    userData != null && userData["name"] != null
                                    ? userData["name"]
                                    : "Unknown User";
                                return Text(
                                  name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                );
                              },
                            ),
                            subtitle: Text(timeAgo),
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
                            child: Image.network(
                              postdata["postImage"]!,
                              fit: BoxFit.cover,
                            ),
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
                                // Like Button with state
                                StreamBuilder<bool>(
                                  stream: postProvider.ispostLiked(
                                    postId,
                                    userId,
                                  ),
                                  builder: (context, snapshot) {
                                    final isLiked = snapshot.data ?? false;
                                    return InkWell(
                                      onTap: userId.isEmpty
                                          ? null
                                          : () => postProvider.togglepostLike(
                                              postId,
                                              userId,
                                            ),
                                      borderRadius: BorderRadius.circular(8),
                                      child: Row(
                                        children: [
                                          Icon(
                                            isLiked
                                                ? Icons.thumb_up
                                                : Icons.thumb_up_alt_outlined,
                                            color: isLiked
                                                ? primaryBlue
                                                : Colors.black54,
                                            size: 22,
                                          ),
                                          const SizedBox(width: 5),
                                          // Like count
                                          Text(
                                            '${postdata["likes"] ?? 0} Like',
                                            style: TextStyle(
                                              color: isLiked
                                                  ? primaryBlue
                                                  : Colors.black54,
                                              fontSize: 15,
                                              fontWeight: isLiked
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      builder: (context) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                const BorderRadius.only(
                                                  topLeft: Radius.circular(24),
                                                  topRight: Radius.circular(24),
                                                ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(
                                                  0.1,
                                                ),
                                                blurRadius: 10,
                                                offset: const Offset(0, -2),
                                              ),
                                            ],
                                          ),
                                          child: DraggableScrollableSheet(
                                            expand: false,
                                            initialChildSize: 0.5,
                                            minChildSize: 0.3,
                                            maxChildSize: 0.9,
                                            builder: (context, scrollController) {
                                              return Column(
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.symmetric(
                                                          vertical: 12,
                                                        ),
                                                    width: 40,
                                                    height: 5,
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[300],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                    ),
                                                  ),
                                                  const Text(
                                                    "Comments",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xFF007BFF),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Expanded(
                                                    child: StreamBuilder<QuerySnapshot>(
                                                      stream: FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                            'Aliposts',
                                                          )
                                                          .doc(postId)
                                                          .collection(
                                                            'comments',
                                                          )
                                                          .orderBy(
                                                            'timestamp',
                                                            descending: true,
                                                          )
                                                          .snapshots(),
                                                      builder: (context, snapshot) {
                                                        if (snapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .waiting) {
                                                          return Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          );
                                                        }

                                                        if (snapshot
                                                            .data!
                                                            .docs
                                                            .isEmpty) {
                                                          return Center(
                                                            child: Text(
                                                              "No comments yet",
                                                            ),
                                                          );
                                                        }
                                                        final comments =
                                                            snapshot.data!.docs;
                                                        // Build your comment list UI here
                                                        return ListView.builder(
                                                          controller:
                                                              scrollController,
                                                          itemCount:
                                                              comments.length,
                                                          itemBuilder: (context, index) {
                                                            final commentData =
                                                                comments[index]
                                                                        .data()
                                                                    as Map<
                                                                      String,
                                                                      dynamic
                                                                    >;
                                                            
                                                            return Card(
                                                              color:
                                                                  index % 2 == 0
                                                                  ? const Color(
                                                                      0xFFEAF4FF,
                                                                    )
                                                                  : const Color(
                                                                      0xFFD1E9FF,
                                                                    ),
                                                              margin:
                                                                  const EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        16,
                                                                    vertical: 6,
                                                                  ),
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      16,
                                                                    ),
                                                              ),
                                                              child: ListTile(
                                                                leading: CircleAvatar(
                                                                  backgroundColor:
                                                                      const Color(
                                                                        0xFF007BFF,
                                                                      ),
                                                                  child: Icon(
                                                                    Icons
                                                                        .person,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                                title: FutureBuilder<String?>(
                                                                  future: authProvider
                                                                      .getUserNameFromId(
                                                                        commentData['userId'],
                                                                      ),
                                                                  builder:
                                                                      (
                                                                        context,
                                                                        snapshot,
                                                                      ) {
                                                                        if (snapshot.connectionState ==
                                                                            ConnectionState.waiting) {
                                                                          return const Text(
                                                                            "Loading...",
                                                                            style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          );
                                                                        }

                                                                        return Text(
                                                                          snapshot.data ??
                                                                              "Unknown User",
                                                                          style: const TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Color(
                                                                              0xFF007BFF,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                ),

                                                                subtitle: Text(
                                                                  commentData['comment']!,
                                                                  style: TextStyle(
                                                                    color: Colors
                                                                        .grey[800],
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  // Comment form UI
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.fromLTRB(
                                                          16,
                                                          8,
                                                          16,
                                                          16,
                                                        ),
                                                    child: Form(
                                                      key: _commentFormKey,
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: TextFormField(
                                                              controller:
                                                                  _commentController,
                                                              validator: (value) {
                                                                if (value ==
                                                                        null ||
                                                                    value
                                                                        .trim()
                                                                        .isEmpty) {
                                                                  return 'Please enter a comment';
                                                                }
                                                                return null;
                                                              },
                                                              decoration: InputDecoration(
                                                                hintText:
                                                                    'Write a comment...',
                                                                filled: true,
                                                                fillColor:
                                                                    const Color(
                                                                      0xFFF3F6FA,
                                                                    ),
                                                                contentPadding:
                                                                    const EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          16,
                                                                      vertical:
                                                                          12,
                                                                    ),
                                                                border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        25,
                                                                      ),
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 8,
                                                          ),
                                                          Material(
                                                            color: const Color(
                                                              0xFF007BFF,
                                                            ),
                                                            shape:
                                                                const CircleBorder(),
                                                            child: IconButton(
                                                              onPressed: () async {
                                                                if (_commentFormKey
                                                                        .currentState
                                                                        ?.validate() ??
                                                                    false) {
                                                                  final commentText =
                                                                      _commentController
                                                                          .text
                                                                          .trim();
                                                                  if (commentText
                                                                      .isNotEmpty) {
                                                                    await postProvider
                                                                        .addComment(
                                                                          postId,
                                                                          commentText,
                                                                          userId,
                                                                        );
                                                                    _commentController
                                                                        .clear();
                                                                    FocusScope.of(
                                                                      context,
                                                                    ).unfocus();
                                                                  }
                                                                }
                                                              },
                                                              icon: const Icon(
                                                                Icons.send,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: _buildAction(
                                    Icons.mode_comment_outlined,
                                    "Comment",
                                    postdata['comments'].toString()
                                  ),
                                ),
                                _buildAction(Icons.share_outlined, "Share", postdata['shares'].toString()),
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
  Widget _buildAction(IconData icon, String label, String count) {
    return Row(
      children: [
        Icon(icon, color: Colors.black54, size: 22),
        const SizedBox(width: 5),
        Text(
          count,
          style: const TextStyle(color: Colors.black54, fontSize: 15),
        ),
        SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(color: Colors.black54, fontSize: 15),
        ),
      ],
    );
  }
}
