import 'dart:io';

class Post {
  final String title;
  final File content;
  final DateTime createdAt;

  Post({
    required this.title,
    required this.content,
    required this.createdAt,
  });
}