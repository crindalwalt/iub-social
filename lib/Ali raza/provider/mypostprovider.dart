import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:iub_social/Ali%20raza/Views/myPost1.dart';

class Mypostprovider extends ChangeNotifier {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Upload image to Firebase Storage
  Future<String?> _uploadImage(File? image) async {
    if (image == null) return null;

    final ref = _storage.ref().child(
      'posts/${DateTime.now().millisecondsSinceEpoch}.jpg',
    );

    final uploadTask = await ref.putFile(image);
    return await uploadTask.ref.getDownloadURL();
  }

  /// Upload post to Firestore
  Future<void> MyuploadPost(Mypost1 post) async {
    String? imageUrl = await _uploadImage(post.content);

    await _firestore.collection("Aliposts").add({
      "postText": post.title,
      "postImage": imageUrl,
      "createdAt": FieldValue.serverTimestamp(),
      "likes": 0,
      "comments": 0,
      "shares": 0,
      "userId": post.userId,
    });

    notifyListeners();
  }
}
