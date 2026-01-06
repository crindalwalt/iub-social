import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ConnectionProvider extends ChangeNotifier {
  final FirebaseFirestore _database = FirebaseFirestore.instance;


  
  void followUser ({required String userId, required String otherUserId}) async {
    // Implementation for following a user
    final userRef = _database.collection("users").doc(userId);
    final otherUserRef = _database.collection("users").doc(otherUserId);  

     await userRef.update({
      "followingCount": FieldValue.increment(1),
    });
   await userRef.collection("following").doc(otherUserId).set({
      "timestamp" : FieldValue.serverTimestamp(),
    });

    await otherUserRef.update({
      "followerCount": FieldValue.increment(1),
    });
    await otherUserRef.collection("followers").doc(userId).set({
      "timestamp" : FieldValue.serverTimestamp(),
    });





    print("user $userId is following user $otherUserId");
  }

    Stream<bool> isUserFollowed(String myId, String userId) {
    final otherUserRef = _database.collection('users').doc(userId);
    final followRef = otherUserRef.collection('followers').doc(myId);
    return followRef.snapshots().map((snapshot) => snapshot.exists);
  }
}