import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String postId;
  final String message;
  final Timestamp? commentedAt;
  final String userId;

  Comment({required this.message, required this.postId, this.commentedAt, required this.userId});
}
