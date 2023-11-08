import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wslc_147_firebase/main.dart';
import 'package:wslc_147_firebase/uihelper.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  signUp(String email,String password)async{
    if(email=="" && password==""){
      log("Enter Required Fields");
    }
    else{
      UserCredential? usercredential;
      try{
        usercredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value){
          log("User Created");
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: "HomeScreen")));
        });
      }on FirebaseAuthException catch(ex){
        log(ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        UiHelper.CustomTextField(emailController,"Email", Icons.mail),
        UiHelper.CustomTextField(passwordController, "Password", Icons.password),
        SizedBox(height: 30),
        ElevatedButton(onPressed: (){
          signUp(emailController.text.toString(), passwordController.text.toString());
        }, child: Text("Sign Up"))
      ],),
    );
  }
}
