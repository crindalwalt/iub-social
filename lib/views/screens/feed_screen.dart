import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iub_social/models/post.dart';
import 'package:iub_social/views/screens/create_post.dart';
import '../../utils/app_colors.dart';
import '../common/custom_app_bar.dart';
import '../common/post_card.dart';
import '../common/story_circle.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: CustomAppBar(
        title: 'IUB Social',
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.pureWhite),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.notifications_outlined,
              color: AppColors.pureWhite,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Stories Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.pureWhite,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: const [
                    StoryCircle(
                      userName: 'Your Story',
                      userInitial: 'Y',
                      isOwn: true,
                    ),
                    StoryCircle(userName: 'Ahmed', userInitial: 'A'),
                    StoryCircle(userName: 'Fatima', userInitial: 'F'),
                    StoryCircle(userName: 'Hassan', userInitial: 'H'),
                    StoryCircle(userName: 'Ayesha', userInitial: 'A'),
                    StoryCircle(userName: 'Usman', userInitial: 'U'),
                    StoryCircle(userName: 'Zainab', userInitial: 'Z'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Create Post Section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.pureWhite,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.lightNavy,
                    child: Text(
                      'Y',
                      style: TextStyle(
                        color: AppColors.pureWhite,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.offWhite,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Text(
                        "What's on your mind?",
                        style: TextStyle(
                          color: AppColors.mediumGray,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(
                      Icons.photo_library,
                      color: AppColors.accentNavy,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // Posts Feed
            // Padding(
            //   padding: const EdgeInsets.all(16),
            //   child: Column(
            //     children: const [
            //       PostCard(
            //         userName: 'Ahmed Khan',
            //         userAvatar: 'AK',
            //         timeAgo: '2 hours ago',
            //         postContent: 'Just finished my CS final exam! Feeling relieved 😊 Good luck to everyone still preparing for their exams. We got this, IUB! 🎓',
            //         likes: 124,
            //         comments: 18,
            //         shares: 5,
            //       ),
            //       PostCard(
            //         userName: 'Fatima Shahid',
            //         userAvatar: 'FS',
            //         timeAgo: '4 hours ago',
            //         postContent: 'The IUB library is such a peaceful place to study. If you haven\'t checked out the 3rd floor, you\'re missing out! 📚',
            //         postImage: 'library.jpg',
            //         likes: 89,
            //         comments: 12,
            //         shares: 3,
            //       ),
            //       PostCard(
            //         userName: 'IUB Student Council',
            //         userAvatar: 'SC',
            //         timeAgo: '6 hours ago',
            //         postContent: '🎉 Annual Sports Week starting next Monday! Register now for cricket, football, basketball, and badminton tournaments. Don\'t miss out! #IUBSports',
            //         postImage: 'sports.jpg',
            //         likes: 256,
            //         comments: 45,
            //         shares: 28,
            //       ),
            //       PostCard(
            //         userName: 'Hassan Ali',
            //         userAvatar: 'HA',
            //         timeAgo: '8 hours ago',
            //         postContent: 'Anyone up for a study group session for Advanced Database Systems? Let\'s meet at the cafeteria tomorrow at 3 PM.',
            //         likes: 42,
            //         comments: 23,
            //         shares: 2,
            //       ),
            //       PostCard(
            //         userName: 'Dr. Maria Siddiqui',
            //         userAvatar: 'MS',
            //         timeAgo: '10 hours ago',
            //         postContent: 'Reminder: Research paper submissions are due this Friday. Make sure to follow the IEEE format guidelines. Good luck!',
            //         likes: 178,
            //         comments: 31,
            //         shares: 12,
            //       ),
            //     ],
            Padding(
              padding: const EdgeInsets.all(16),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('posts')
                    .orderBy('timeCreated', descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

                  final posts = snapshot.data!.docs;

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    primary: false,
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final data = posts[index].data() as Map<String, dynamic>;

                      return PostCard(
                        userId: data['userId'] ?? 'Unknown User',
                        userAvatar: data['userAvatar'] ?? 'U',
                        timeAgo: data['timeCreated'] ?? 'Just now',
                        postContent: data['postContent'] ?? '',
                        likes: data['likes'] ?? 0,
                        comments: data['comments'] ?? 0,
                        shares: data['shares'] ?? 0,
                        postImage: data['postImage'],
                      );
                    },
                  );
                },
              ),
            ),

            //dummy data driven posts
            // Padding(
            //   padding: EdgeInsets.all(16),
            //   child: ListView.builder(
            //     itemCount: dummyPosts.length,
            //     shrinkWrap: true,
            //     physics: NeverScrollableScrollPhysics(),
            //     primary: false,
            //     itemBuilder: (context, index) {

            //       final post = dummyPosts[index];
            //       return PostCard(
            //         userName: post.userName,
            //         userAvatar: post.userAvatar,
            //         timeAgo: post.timeAgo,
            //         postContent: post.postContent,
            //         likes: post.likes,
            //         comments: post.comments,
            //         shares: post.shares,
            //         postImage: post.postImage,
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => CreatePostScreen()));
        },
        backgroundColor: AppColors.accentNavy,
        child: const Icon(Icons.add, color: AppColors.pureWhite),
      ),
    );
  }
}
