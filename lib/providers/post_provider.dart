import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:iub_social/models/post.dart';

class PostProvider extends ChangeNotifier {
  FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseFirestore _database = FirebaseFirestore.instance;

  Future<String> uploadFileToStorage(Post post) async {
    // create a refrence for new uploads
    final Reference storageRef = _storage.ref().child(
      'posts/${post.title}_${DateTime.now().millisecondsSinceEpoch}',
    );

    // upload the file
    final TaskSnapshot uploadingFile = await storageRef.putFile(post.content);

    // get a downloadableLink for storing in the database
    final downloadLink = await uploadingFile.ref.getDownloadURL();

    notifyListeners();
    // returning the downloadable link
    return downloadLink;
  }

  void uploadPost(Post post) async {
    String postLink = await uploadFileToStorage(post);

    final uploadingPost = await _database.collection("posts").add({
      "post": post.title,
      "imageUrl": postLink,
    });
  }
}
