import 'package:fire/addPost.dart';
import 'package:fire/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class post extends StatefulWidget {
  const post({super.key});

  @override
  State<post> createState() => _postState();
}

class _postState extends State<post> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('post');
  final searchController = TextEditingController();
  final editController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Home "),
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => login()));
                }).onError((error, StackTrace) {});
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Search Bar..."),
              onChanged: (String value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
              child: FirebaseAnimatedList(
                  query: ref,
                  itemBuilder: (context, snepshot, animation, index) {
                    final title = snepshot.child('title').value.toString();
                    final id = snepshot.child('id').value.toString();

                    if (searchController.text.isEmpty) {
                      return ListTile(
                        title: Text(snepshot.child('title').value.toString()),
                        trailing: PopupMenuButton<String>(
                          icon: Icon(Icons.more_vert),
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem(
                                value: '1',
                                onTap: () {
                                  Navigator.pop(context);
                                  showMyDailog(title, id);
                                },
                                child: ListTile(
                                  leading: Icon(Icons.edit),
                                  title: Text("edit"),
                                ),
                              ),
                              PopupMenuItem(
                                value: '2',
                                onTap: () {
                                  ref.child(snepshot.child(id).value.toString()).remove();
                                },
                                child: ListTile(
                                  leading: Icon(Icons.delete),
                                  title: Text("delete"),
                                ),
                              )
                            ];
                          },
                        ),
                      );
                    } else if (title.toLowerCase().toString().contains(
                        searchController.text.toLowerCase().toString())) {
                      return ListTile(
                        title: Text(snepshot.child('title').value.toString()),
                      );
                    } else {
                      return Container();
                    }
                  }))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => addPost()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> showMyDailog(String title, String id) async {
    editController.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("update"),
            content: Container(
              child: TextFormField(
                controller: editController,
                decoration: InputDecoration(
                  hintText: "edit text",
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => post()));
                  },
                  child: Text("cancel")),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => post()));

                    ref
                        .child(id)
                        .update({'title': editController.text.toLowerCase()});
                  },
                  child: Text("update"))
            ],
          );
        });
  }
}

 // ListTile(
                                //   trailing: PopupMenuButton<String>(
                                //     icon: Icon(Icons.more_vert),
                                //     itemBuilder: (BuildContext context) {
                                // print( " this is the data"+ users[index]['createdAt'].toString());
                                // return [
                                //   PopupMenuItem(
                                //     value: '1',
                                //     onTap: () {
                                //       showMyDialog(
                                //           users[index]['name'].toString(),
                                //           users[index]['id'].toString());
                                //     },
                                //     child: ListTile(
                                //       leading: Icon(Icons.edit),
                                //       title: Text("edit"),
                                //     ),
                                //   ),
                                //   PopupMenuItem(
                                //     value: '2',
                                //     onTap: () {
                                //       ref
                                //           .doc(users[index]['id'].toString())
                                //           .delete();
                                //       // ref.child(snepshot.child(id).value.toString()).remove();
                                //     },
                                //     child: ListTile(
                                //       leading: Icon(Icons.delete),
                                //       title: Text("delete"),
                                //     ),
                                //   )
                                //     ];
                                //   },
                                // ),
                                // title: Text(users[index]['name'].toString()),
                                //   subtitle: Text(date != null
                                //       ? date.toString()
                                //       : 'No timestamp available'),
                                // ),
