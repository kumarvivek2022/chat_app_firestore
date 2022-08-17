import 'package:chatapp/views/signup.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  final Function toggleView;

  WelcomeScreen(this.toggleView);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: Image.asset("assets/images/welcome.png",height: 300,),
                )),
            SizedBox(
              height: 25,
            ),
            Text("Hey ! Welcome",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    fixedSize: const Size(200, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SignUp()));
                },
                child: Text("GET STARTED",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),
          ],
        ));
  }
}
