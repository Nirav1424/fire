import 'package:fire/custom/roundedButton.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class addPost extends StatefulWidget {
  const addPost({super.key});

  @override
  State<addPost> createState() => _addPostState();
}

class _addPostState extends State<addPost> {
  bool loading = false;
  final databaseref = FirebaseDatabase.instance.ref('post');
  final textcontroller = TextEditingController();

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
                  setState(() {
                    loading = true;
                  });

                  String id = DateTime.now().microsecondsSinceEpoch.toString();

                  databaseref.child(id).set({
                    'title': textcontroller.text.toString(),
                    'id': id,
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
