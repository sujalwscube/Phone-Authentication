import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wslc_147_firebase/uihelper.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController=TextEditingController();
  forgot(String email){
    FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value){
      log("OTP Sent on Your Email");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        UiHelper.CustomTextField(emailController, "Email", Icons.mail),
          SizedBox(height: 20),
          ElevatedButton(onPressed: (){
            forgot(emailController.text.toString());
          }, child: Text("Send OTP"))
      ],),
    );
  }
}
