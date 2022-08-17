import 'package:chat_application_firebase/presentation/screen/call_screen.dart';
import 'package:chat_application_firebase/presentation/screen/chat_screen.dart';
import 'package:chat_application_firebase/presentation/screen/contact_screen.dart';
import 'package:chat_application_firebase/presentation/screen/profile_screen.dart';
import 'package:chat_application_firebase/presentation/screen/story_screen.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int currentIndex = 0;
  final List pages = [
    const ChatScreen(),
    const CallScreen(),
    const StoryScreen(),
    const ContactScreen(),
    const ProfileScreen(),
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
            icon: Icon(Icons.camera_alt),
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
