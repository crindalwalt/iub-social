import 'dart:io';

class Mypost1 {
  final String title;
  final File? content;
  final DateTime createdAt;
  final String userId;

  Mypost1({
    required this.title,
    required this.content,
    required this.createdAt,
    required this.userId,
  });
}
