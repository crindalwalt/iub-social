import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iub_social/providers/authentication_provider.dart';
import 'package:iub_social/providers/post_provider.dart';
import 'package:provider/provider.dart';
import '../../utils/app_colors.dart';

class PostCard extends StatelessWidget {
  final String userId;
  final String id;
  final String userAvatar;
  final Timestamp timeAgo;
  final String postContent;
  final String? postImage;
  final int likes;
  final int comments;
  final int shares;

  const PostCard({
    super.key,
    required this.id,
    required this.userId,
    required this.userAvatar,
    required this.timeAgo,
    required this.postContent,
    this.postImage,
    required this.likes,
    required this.comments,
    required this.shares,
  });

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthenticationProvider>(context, listen: false);
    final postProvider = Provider.of<PostProvider1>(context);
    // final isLikedFuture = postProvider.isPostLiked(postId, userId)
    final userName = auth.getUserNameFromId(userId);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.lightNavy,
                  child: Text(
                    userAvatar,
                    style: const TextStyle(
                      color: AppColors.pureWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                FutureBuilder(
                  future: userName,
                  builder: (context, snapshot) {
                    return Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data == null
                                ? "Anonymous"
                                : snapshot.data!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: AppColors.primaryNavy,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            DateFormat(
                              'EEEE, MMM d, yyyy',
                            ).format(timeAgo.toDate()),
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.darkGray,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert, color: AppColors.darkGray),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              postContent,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.primaryNavy,
                height: 1.4,
              ),
            ),
          ),

          // Image (if exists)
          if (postImage != null) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              height: 250,
              color: AppColors.lightGray,
              child: Image.network(postImage!, fit: BoxFit.cover),
            ),
          ],

          const SizedBox(height: 12),

          // Stats
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  '$likes likes',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.darkGray,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  '$comments comments',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.darkGray,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 24, thickness: 1),

          // Actions
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                StreamBuilder(
                  stream: postProvider.isPostLiked(id, userId),

                  builder: (context, snapshot) {
                    print("Post id =====================");
                    print(id);
                    print("snapshot data of post inside builder");
                    print(snapshot.data);
                    return _LikeButton(
                      liked: snapshot.data ?? false,
                      icon: Icons.thumb_up_outlined,
                      label: 'Like',
                      onTap: () async {
                        print("post is liked =========");
                        await postProvider.togglePostLike(id, userId);
                      },
                    );
                  },
                ),
                _ActionButton(
                  icon: Icons.comment_outlined,
                  label: 'Comment',
                  onTap: () {},
                ),
                _ActionButton(
                  icon: Icons.share_outlined,
                  label: 'Share',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppColors.darkGray),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.darkGray,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LikeButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool liked;
  final VoidCallback onTap;

  const _LikeButton({
    required this.liked,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: liked
            ? Row(
                children: [
                  Icon(Icons.thumb_up, size: 20, color: AppColors.accentNavy),
                  const SizedBox(width: 6),
                  Text(
                    "Liked",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkGray,
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  Icon(
                    Icons.thumb_up_outlined,
                    size: 20,
                    color: AppColors.darkGray,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "Like",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkGray,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
