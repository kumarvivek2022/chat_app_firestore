import 'package:flutter/material.dart';
class CustomTextField extends StatelessWidget {

  final String hintText;
  final TextEditingController controller;
  CustomTextField({Key key, this.hintText, this.controller}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.9), width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        //filled: true,
        hintStyle: TextStyle(color: Colors.grey[800]),
        hintText: hintText,
        errorStyle: const TextStyle(color: Colors.white),
        fillColor: Colors.grey.withOpacity(0.2),
      ),
      style: TextStyle(color: Colors.grey.withOpacity(0.9)),
    );
  }

}