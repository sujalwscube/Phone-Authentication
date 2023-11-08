import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wslc_147_firebase/fetchdata.dart';
import 'package:wslc_147_firebase/uihelper.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController titleController=TextEditingController();
  TextEditingController descController=TextEditingController();
  TextEditingController idController=TextEditingController();

  adddata(String title,String desc,String id){
    if(title=="" && desc=="" && id==""){
      log("Enter Required Fields");
    }
    else{
      FirebaseFirestore.instance.collection("Notes").doc(id).set({
        "Title":title,
        "Description":desc,
        "Id":id
      }).then((value){
        log("Data Inserted");
        Navigator.push(context, MaterialPageRoute(builder: (context)=>FetchData()));
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Data"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        UiHelper.CustomTextField(titleController,"Title", Icons.title),
        UiHelper.CustomTextField(descController, "Description", Icons.description),
        UiHelper.CustomTextField(idController, "Id", Icons.insert_drive_file),
        SizedBox(height: 30),
        ElevatedButton(onPressed: (){
          adddata(titleController.text.toString(), descController.text.toString(), idController.text.toString());
        }, child: Text("Add Data"))

      ],),
    );
  }
}
