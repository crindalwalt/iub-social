import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:iub_social/models/comment.dart';
import 'package:iub_social/models/create_post.dart';
import 'package:iub_social/models/post.dart';

class PostProvider1 extends ChangeNotifier {
  FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseFirestore _database = FirebaseFirestore.instance;

  Future<String> uploadFileToStorage(CreatePost post) async {
    // create a refrence for new uploads
    final Reference storageRef = _storage.ref().child(
      'posts/${post.content}_${DateTime.now().millisecondsSinceEpoch}',
    );

    // upload the file
    final TaskSnapshot uploadingFile = await storageRef.putFile(
      post.imageFile!,
    );

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
      "likes": 0,
      "comments": 0,
      "shares": 0,
      "userId": post.userId,
    };
    final uploadingPost = await _database.collection("posts").add(postData);
  }

  // ========================================================
  // Like system
  //======================================================

  Stream<bool> isPostLiked(String postId, String userId) {
    final postRef = _database.collection('posts').doc(postId);
    final likeRef = postRef.collection('likes').doc(userId);
    return likeRef.snapshots().map((snapshot) => snapshot.exists);
  }

  Future<void> togglePostLike(String postId, String userId) async {
    final postRef = _database.collection('posts').doc(postId);
    final likeRef = postRef.collection('likes').doc(userId);
    final likeSnapshot = await likeRef.get();
    if (likeSnapshot.exists) {
      await likeRef.delete();
      postRef.update({"likes": FieldValue.increment(-1)});
    } else {
      postRef.update({"likes": FieldValue.increment(1)});
      await likeRef.set({
        "userId": userId,
        "timestamp": FieldValue.serverTimestamp(),
      });
    }
  }

  Future<void> addComment(Comment comment) async {
    final postRef = _database.collection("posts").doc(comment.postId);

    
    final commentRef = await postRef.collection("comments").add({
      "message": comment.message,
      "postId": comment.postId,
      "commentedAt": FieldValue.serverTimestamp(),
      "userId": comment.userId,
    });
    postRef.update({"comments": FieldValue.increment(1)});


    notifyListeners();
  }


  Future<Comment> fetchAllCommentsForPost({required String postId}) async {
    final postRef = _database.collection("posts").doc(postId);
    final commentsRef = postRef.collection("comments");
    final snapshot = await commentsRef.get();
    final List<Comment> comments = [];
    for (final doc in snapshot.docs) {
      final data = doc.data();
      comments.add(Comment(
        postId: data["postId"],
        message: data["message"],
        userId: data["userId"],
      ));
    }
    return comments.first;
  }



}