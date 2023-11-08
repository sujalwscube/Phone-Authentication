import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:wslc_147_firebase/main.dart';
import 'package:wslc_147_firebase/phoneauth.dart';

class OTPScreen extends StatefulWidget {
   OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController OtpController=TextEditingController();
  var code="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         TextField(
           controller: OtpController,
         ),
          SizedBox(height: 30),
          ElevatedButton(onPressed: ()async{
            try{
              PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: PhoneAuth.verify, smsCode: OtpController.text.toString());
              // Sign the user in (or link) with the credential
              await FirebaseAuth.instance.signInWithCredential(credential).then((value){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>MyHomePage(title: "Phone Auth")));
              });
            }
            catch(ex){
              log(ex.toString());
            }
          }, child: Text("OTP"))


        ],
      ),
    );
  }
}
