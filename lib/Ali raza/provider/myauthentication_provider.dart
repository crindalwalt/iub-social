import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationProvider1 extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  User? _user;

  AuthenticationProvider1() {
    _firebaseAuth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  /// 🔹 Getter (use this everywhere)
  User? get user => _user;

  // ---------------- LOGIN ----------------
  Future<bool> loginToAccount({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // user will be set automatically by authStateChanges
      return true;
    } catch (e) {
      debugPrint("Login Error: $e");
      return false;
    }
  }

  // ---------------- REGISTER ----------------
  Future<bool> registerToAccount({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Optional: set display name
      await userCredential.user?.updateDisplayName(name);

      // Store user info in Firestore for name lookup
      await _database.collection("myusers").doc(userCredential.user!.uid).set({
        "name": name,
        "email": email,
        "createdAt": DateTime.now(),
      });

      return true;
    } catch (e) {
      debugPrint("Register Error: $e");
      return false;
    }
  }

  // ---------------- LOGOUT ----------------
  Future<void> logoutFromAccount() async {
    await _firebaseAuth.signOut();
    _user = null;
    notifyListeners();
  }

 Future<String?> getUserNameFromId(String userId) async {
    final user = await _database.collection("myusers").doc(userId).get();
    final userData = user.data()!;
    final username = userData["name"];
    return username;
  }
}
