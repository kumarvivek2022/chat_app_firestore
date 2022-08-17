import 'package:flutter/material.dart';
class Story extends StatefulWidget {
  const Story({Key key}) : super(key: key);

  @override
  State<Story> createState() => _StoryState();
}

class _StoryState extends State<Story> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("StoryScreen")),
    );
  }
}
