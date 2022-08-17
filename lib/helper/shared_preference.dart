import 'package:chatapp/presentation/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin LogOut{
  void logOut(BuildContext context) async{
    SharedPreferences userIsLoggedIn = await SharedPreferences.getInstance();
    userIsLoggedIn.clear();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> WelcomeScreen()));
  }
}