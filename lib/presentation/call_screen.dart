import 'package:flutter/material.dart';
class Call extends StatefulWidget {
  const Call({Key key}) : super(key: key);

  @override
  State<Call> createState() => _CallState();
}

class _CallState extends State<Call> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("CallScreen")),
    );
  }
}
