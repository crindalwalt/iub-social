import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iub_social/models/comment.dart';
import 'package:iub_social/providers/authentication_provider.dart';
import 'package:iub_social/providers/connection_provider.dart';
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
    final connectionProvider = Provider.of<ConnectionProvider>(context);
    final TextEditingController _commentController = TextEditingController();
    final GlobalKey<FormState> _commentFormKey = GlobalKey<FormState>();
    // final isLikedFuture = postProvider.isPostLiked(postId, userId)
    final userName = auth.getUserNameFromId(userId);

    void submitComment() async {
      print("Comment submitted");
      if (_commentFormKey.currentState!.validate()) {
        // Add comment submission logic here

        final String message = _commentController.text;
        final userId = auth.user!.uid;

        print("we recieved a new comment ");
        print(_commentController.text);
        print("by  $userId");

        final Comment newComment = Comment(
          postId: id,
          message: message,
          userId: userId,
        );
        await postProvider.addComment(newComment);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Comment added successfully")));
        Navigator.pop(context);
      }
    }

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
                          SizedBox(height: 7),
                          InkWell(
                            onTap: () {
                              print("you are following user $userId ....");
                              final myId = auth.user!.uid;
                              connectionProvider.followUser(
                                userId: myId,
                                otherUserId: userId,
                              );
                            },
                            child: StreamBuilder(
                              stream: connectionProvider.isUserFollowed(
                                auth.user!.uid,
                                userId,
                              ),
                              builder: (context, snapshot) {
                                if (snapshot.data! == true) {
                                  // if followed
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.grey,
                                        style: BorderStyle.solid,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.check),
                                        SizedBox(width: 5),
                                        Text("Following"),
                                      ],
                                    ),
                                  );
                                } else {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.grey,
                                        style: BorderStyle.solid,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.add),
                                        SizedBox(width: 5),
                                        Text("Follow"),
                                      ],
                                    ),
                                  );
                                }
                              },
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
                  onTap: () {
                    showModalBottomSheet(
                      showDragHandle: true,
                      isScrollControlled: true,
                      context: context,
                      backgroundColor: AppColors.pureWhite,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) {
                        return DraggableScrollableSheet(
                          expand: false,
                          initialChildSize: 0.7,
                          minChildSize: 0.4,
                          maxChildSize: 0.95,
                          builder: (context, scrollController) {
                            return Padding(
                              padding: EdgeInsets.only(
                                left: 16,
                                right: 16,
                                top: 16,
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom +
                                    16,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.comment,
                                        color: AppColors.primaryNavy,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "Comments",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primaryNavy,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  const Divider(height: 1, thickness: 1),
                                  const SizedBox(height: 8),
                                  // Comments List
                                  Expanded(
                                    child: ListView.separated(
                                      controller: scrollController,
                                      itemCount:
                                          4, // TODO: Replace with actual comments count
                                      separatorBuilder: (context, idx) =>
                                          const Divider(height: 20),
                                      itemBuilder: (context, idx) {
                                        // TODO: Replace with actual comment data
                                        return Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CircleAvatar(
                                              radius: 18,
                                              backgroundColor:
                                                  AppColors.lightNavy,
                                              child: Text(
                                                "U", // TODO: User initial
                                                style: const TextStyle(
                                                  color: AppColors.pureWhite,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "User Name", // TODO: User name
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: AppColors
                                                              .primaryNavy,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Text(
                                                        "2h ago", // TODO: Time ago
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          color: AppColors
                                                              .darkGray,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 2),
                                                  Text(
                                                    "This is a sample comment.", // TODO: Comment text
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      color:
                                                          AppColors.primaryNavy,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  // Add Comment Form
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.offWhite,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Form(
                                      key: _commentFormKey,

                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              controller: _commentController,
                                              minLines: 1,
                                              maxLines: 3,
                                              decoration: const InputDecoration(
                                                hintText: "Write a comment...",
                                                border: InputBorder.none,
                                                isDense: true,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Material(
                                            color: AppColors.accentNavy,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              onTap: submitComment,
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Icon(
                                                  Icons.send,
                                                  color: AppColors.pureWhite,
                                                  size: 22,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
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
