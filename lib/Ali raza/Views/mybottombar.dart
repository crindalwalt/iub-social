import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:iub_social/Ali%20raza/Views/message.dart';
import 'package:iub_social/Ali%20raza/Views/myprofile.dart';
import 'package:iub_social/views/screens/feed_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final List<Widget> screens = [
    FeedScreen(),
    MessengerChatScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        backgroundColor: Colors.transparent,
        color: const Color.fromARGB(255, 103, 176, 235),
        buttonBackgroundColor: Colors.blue,
        height: 55,

        items: const [
          Icon(Icons.home_rounded, size: 30, color: Colors.white),
          Icon(Icons.message_rounded, size: 30, color: Colors.white),
          Icon(Icons.person_outline_rounded, size: 30, color: Colors.white),
        ],

        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),

      body: screens[_selectedIndex],
    );
  }
}
