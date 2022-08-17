
import 'package:chatapp/presentation/call_screen.dart';
import 'package:chatapp/presentation/chatrooms.dart';
import 'package:chatapp/presentation/contact_screen.dart';
import 'package:chatapp/presentation/profile_screen.dart';
import 'package:chatapp/presentation/story_screen.dart';
import 'package:flutter/material.dart';

import '../presentation/chat.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key key}) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int currentIndex = 0;
  final List pages = [
    ChatRoom(),
    Call(),
    Story(),
    Contact(),
    Profile(),
  ];

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: const Color(0xFF6683df),
        unselectedItemColor: const Color(0xFFa6afcc),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'call',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt_outlined),
            label: 'story',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'contact',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'profile',
          ),
        ],
      ),
    );
  }
}
