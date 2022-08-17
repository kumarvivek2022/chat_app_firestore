import 'dart:developer';
import 'package:chatapp/helper/helperfunctions.dart';
import 'package:chatapp/services/auth.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/widget/custom_bottom_navigation_bar.dart';
import 'package:chatapp/widget/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController phoneEditingController = new TextEditingController();
  TextEditingController otpController = new TextEditingController();

  AuthService authService = new AuthService();
  FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  bool isLoading = false;
  bool isOtpSent = false;
  String vId;

  void signInWithPhoneAuthCredential(AuthCredential phoneAuthCredential) async {
    log("vivek$phoneAuthCredential");
    setState(() {
      isLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      if (kDebugMode) {
        print("vivek2 ${authCredential.user.phoneNumber}");
      }
      if (kDebugMode) {
        print("vivek3 ${authCredential.user.uid}");
      }

      setState(() {
        isLoading = false;
      });

      if (authCredential.user != null) {
        if (authCredential.user.phoneNumber != null) {
          createUserId();
        }
      }
    } on AuthException catch (e) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }

  createUserId() async {
    setState(() {
      isLoading = true;
    });
    Map<String, String> userDataMap = {
      "userName": phoneEditingController.text,
      "userPhone": phoneEditingController.text
    };

    databaseMethods.addUserInfo(userDataMap);

    HelperFunctions.saveUserLoggedInSharedPreference(true);
    HelperFunctions.saveUserNameSharedPreference(phoneEditingController.text);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => CustomBottomNavigationBar()));
  }

  signUp() async {
    setState(() {
      isLoading = true;
    });
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneEditingController.text,
        verificationCompleted: (phoneAuthCredential) async {
          log("here1");
          log("here$phoneAuthCredential");
          setState(() {
            isLoading = false;
          });
        },
        verificationFailed: (verificationFailed) async {
          if (kDebugMode) {
            print("here2");
          }
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(verificationFailed.message.toString())));
        },
        codeAutoRetrievalTimeout: (verificationId) async {
          if (kDebugMode) {
            print("here4");
          }
        },
        codeSent: (String verificationId, [int forceResendingToken]) async {
          if (kDebugMode) {
            print("here3");
          }
          setState(() {
            isOtpSent = true;
            isLoading = false;
            vId = verificationId;
            if (kDebugMode) {
              print(vId.toString());
            }
          });
        },
        timeout: Duration(seconds: 10));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? Container(
                child: Center(
                    child: CircularProgressIndicator()),
              )
            : Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: isOtpSent == false
                    ? Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/login.png",
                              height: 300,
                            ),
                            Form(
                              key: formKey,
                              child: CustomTextField(
                                hintText: "phone Number",
                                controller: phoneEditingController,
                              )
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            GestureDetector(
                              onTap: () {
                                signUp();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    gradient: LinearGradient(
                                      colors: [
                                        const Color(0xff007EF4),
                                        const Color(0xff2A75BC)
                                      ],
                                    )),
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  "Verify",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Column(children: [
                          Image.asset("assets/images/login1.png",
                            height: 300,
                          ),
                          Form(
                            key: formKey2,
                            child: Column(
                              children: [
                              CustomTextField(
                                hintText: "Enter Otp",
                                controller: otpController,
                              ),
                                SizedBox(
                                  height: 16,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    AuthCredential phoneAuthCredential =
                                        PhoneAuthProvider.getCredential(
                                            verificationId: vId,
                                            smsCode: otpController.text);
                                    signInWithPhoneAuthCredential(
                                        phoneAuthCredential);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        gradient: LinearGradient(
                                          colors: [
                                            const Color(0xff007EF4),
                                            const Color(0xff2A75BC)
                                          ],
                                        )),
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(
                                      "Confirm",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]),
                      )));
  }
}
