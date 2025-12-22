import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:iub_social/Ali%20raza/Views/mylogin.dart';
import 'package:iub_social/Ali%20raza/views/alihome.dart';


class   AuthWrapper1 extends StatefulWidget {
  const AuthWrapper1({super.key});

  @override
  State<AuthWrapper1> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper1> {
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      return MyHome();
    }
    return LoginScreen1();
  }
}
