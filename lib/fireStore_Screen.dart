import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire/custom/roundedButton.dart';
import 'package:fire/firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class fireStore_Screen extends StatefulWidget {
  const fireStore_Screen({super.key});

  @override
  State<fireStore_Screen> createState() => _fireStore_ScreenState();
}

class _fireStore_ScreenState extends State<fireStore_Screen> {
  bool loading = false;
  // final databaseref = FirebaseDatabase.instance.ref('post');
  final textcontroller = TextEditingController();
  final firestore = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("add post"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: textcontroller,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RoundedButton(
                loading: loading,
                text: "add post",
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => fireStore()));
                  setState(() {
                    loading = true;
                  });
                  String id = DateTime.now().microsecondsSinceEpoch.toString();
                  firestore.doc(id).set({
                    'name': textcontroller.text.toString(),
                    'amount':10,
                    'id': id,
                    'timestamp': FieldValue.serverTimestamp(),
                  }).then((value) {
                    setState(() {
                      loading = false;
                    });
                  }).onError((error, StackTrace) {
                    setState(() {
                      loading = false;
                    });
                  });
                }),
          )
        ],
      ),
    );
  }



}
