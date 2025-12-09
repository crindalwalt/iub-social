import 'dart:io';

class CreatePost {
  final String content;
  final File? imageFile;
  final DateTime createdAt = DateTime.now();
  final String userId;

  CreatePost({required this.content, this.imageFile, required this.userId });
}