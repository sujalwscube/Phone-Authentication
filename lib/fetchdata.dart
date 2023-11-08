import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FetchData extends StatefulWidget {
  const FetchData({super.key});

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stream Builder"),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Notes").snapshots(),
          builder: (context,snapshot){
            if(snapshot.connectionState==ConnectionState.active){
              if(snapshot.hasData){
                return ListView.builder(itemBuilder: (context,index){
                  return ListTile(
                    leading: Text("${index+1}"),
                    title: Text("${snapshot.data!.docs[index]["Id"]}"),
                    subtitle: Text("${snapshot.data!.docs[index]["Description"]}"),
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
