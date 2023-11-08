import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wslc_147_firebase/otpscreen.dart';
import 'package:wslc_147_firebase/uihelper.dart';

class PhoneAuth extends StatefulWidget {
  static String verify="";
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  TextEditingController phoneController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Authentication"),
        centerTitle: true,
      ),
      body: Column(children: [
        UiHelper.CustomTextField(phoneController, "Phone", Icons.phone),
        SizedBox(height: 20),
        ElevatedButton(onPressed: ()async{
          await FirebaseAuth.instance.verifyPhoneNumber(verificationCompleted: (PhoneAuthCredential phoneauthcredential){}, verificationFailed: (FirebaseAuthException e){}, codeSent: (String verificationId,int? resendtoken){
            PhoneAuth.verify=verificationId;
            Navigator.push(context,MaterialPageRoute(builder: (context)=>OTPScreen()));

          }, codeAutoRetrievalTimeout: (String id){

          },phoneNumber: phoneController.text.toString());
        }, child: Text("Send OTP"))
      ],),
    );
  }
}
