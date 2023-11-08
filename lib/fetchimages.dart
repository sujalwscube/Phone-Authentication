import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FetchImages extends StatefulWidget {
  const FetchImages({super.key});

  @override
  State<FetchImages> createState() => _FetchImagesState();
}

class _FetchImagesState extends State<FetchImages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fetch Images"),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Users").snapshots(),
          builder: (context,snapshot){
            if(snapshot.connectionState==ConnectionState.active){
              if(snapshot.hasData){
                return ListView.builder(itemBuilder: (context,index){
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage("${snapshot.data!.docs[index]["ImageURL"]}"),
                    ),
                    title: Text("${snapshot.data!.docs[index]["ImageName"]}"),
                  );
                },itemCount: snapshot.data!.docs.length,);
              }
              else if(snapshot.hasError){
                return Center(child: Text("${snapshot.hasError.toString()}"),);
              }
              else{
                return Center(child: Text("Data Not Found!!"),);
              }
            }
            else{
              return Center(child: CircularProgressIndicator(),);
            }
          }),
    );
  }
}
