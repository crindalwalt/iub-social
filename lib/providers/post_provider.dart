import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:iub_social/models/post.dart';

class PostProvider extends ChangeNotifier {
  FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseFirestore _database = FirebaseFirestore.instance;

  Future<String> uploadFileToStorage(CreatePost post) async {
    // create a refrence for new uploads
    final Reference storageRef = _storage.ref().child(
      'posts/${post.title}_${DateTime.now().millisecondsSinceEpoch}',
    );

    // upload the file
    final TaskSnapshot uploadingFile = await storageRef.putFile(post.imageFile);

    // get a downloadableLink for storing in the database
    final downloadLink = await uploadingFile.ref.getDownloadURL();

    notifyListeners();
    // returning the downloadable link
    return downloadLink;
  }

  void uploadPost(CreatePost post) async {
    String postLink = await uploadFileToStorage(post);
    Map<String, dynamic> postData = {
      "postContent": post.content,
      "postImage": postLink,
      "timeCreated": FieldValue.serverTimestamp(),
      "likes" : 0,
      "comments" : 0,
      "shares" : 0,
      "userId" : post.userId,
    };
    final uploadingPost = await _database.collection("posts").add(postData);
  }
}
