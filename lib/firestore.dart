

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire/addPost.dart';
import 'package:fire/bottomSheet.dart';
import 'package:fire/custom/roundedButton.dart';
import 'package:fire/fireStore_Screen.dart';
import 'package:fire/login.dart';
import 'package:fire/viewAllDetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class fireStore extends StatefulWidget {
  const fireStore({super.key});

  @override
  State<fireStore> createState() => _fireStoreState();
}

class _fireStoreState extends State<fireStore> {
  double totalPrice = 0.0;
  // final List<Map<String, dynamic>> _data = [
  //   {'id': 1, 'name': 'Item 1', 'date': DateTime(2024, 12, 28)},
  //   {'id': 2, 'name': 'Item 2', 'date': DateTime(2024, 12, 25)},
  //   {'id': 3, 'name': 'Item 3', 'date': DateTime(2024, 12, 29)},
  //   {'id': 4, 'name': 'Item 4', 'date': DateTime(2024, 12, 26)},
  // ];
  // List<Map<String, dynamic>> _filteredData = [];
  String _selectedDate = '';
  void initState() {
    super.initState();
    calculateTotalPrice();
    // _filterDataByDate();
    // _fetchData();
  }

  final auth = FirebaseAuth.instance;
  bool loading = false;
  String formattedDate = "";
  final nameController = TextEditingController();
  final amoutController = TextEditingController();
  final qtyController = TextEditingController();
  final numberController = TextEditingController();
  final totalEdit = TextEditingController();
  final numberEdit = TextEditingController();

  final qtyEdit = TextEditingController();
  final amoutEdit = TextEditingController();
  final nameEdit = TextEditingController();
  final firestore = FirebaseFirestore.instance.collection('users');
  // final ref = FirebaseDatabase.instance.ref('post');
  // final searchController = TextEditingController();
  final editController = TextEditingController();
  final SearchController = TextEditingController();
  final ref = FirebaseFirestore.instance.collection('users');
  final fireStore = FirebaseFirestore.instance
      .collection('users')
      .orderBy('timestamp', descending: true)
      .snapshots();

  // void _filterDataByDate(DateTime date) {
  //   setState(() {
  //     _selectedDate = date;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "fire Store ",
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => login()));
                }).onError((error, StackTrace) {});
              },
              icon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Icon(Icons.logout, color: Colors.white),
              ))
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    controller: SearchController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Search Bar..."),
                    onChanged: (String value) {
                      setState(() {});
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null && picked != DateTime.now()) {
                        // Format the picked date to "YYYY-MM-DD"
                        formattedDate = DateFormat('yyyy-MM-dd').format(picked);
                        setState(() {
                          _selectedDate =
                              formattedDate; // Update the selected date
                        });
                      }
                    },
                    child: Text("Date"),
                  ),
                ),
              ),
            ],
          ),
          StreamBuilder<QuerySnapshot>(
              stream: fireStore,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snepshot) {
                if (snepshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snepshot.hasError) {
                  return Text("Somthing went wrong");
                }

                final users = snepshot.data!.docs;

                return Expanded(
                  child: ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        // final timestamp =
                        //     users[index]['timestamp'] as Timestamp?;
                        // final date = timestamp?.toDate();
                        // final FormateDate = date != null
                        //     ? DateFormat('yyyy-MM-dd').format(date)
                        //     : "not available";
                        String date = users[index]['date'].toString();
                        // print("date is ${date}");
                        // print("selected date is ${_selectedDate}");

                        String title = users[index]['name'].toString();
                        if (SearchController.text.isEmpty &&
                            _selectedDate == null) {
                          return CardContainer(users, index, context);
                        } else if (title.toLowerCase().contains(
                                SearchController.text.toLowerCase()) &&
                            date.contains(_selectedDate)) {
                          return CardContainer(users, index, context);
                        } else {
                          return Container();
                        }
                      }),
                );
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _bottemsheet();
        },
        backgroundColor: Colors.deepPurple,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Card CardContainer(List<QueryDocumentSnapshot<Object?>> users, int index,
      BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Date: ${users[index]['date'].toString()} ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),

                          Text(
                            'Name: ${users[index]['name'].toString()} ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              launch(
                                  'tel:+91${users[index]['number'].toString()}');
                              // FlutterPhoneDirectCaller.callNumber(
                              //     '+91 ${users[index]['number'].toString()}');
                            },
                            child: Text(
                              'number: ${users[index]['number'].toString()} ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 10),
                          // Remove FittedBox and allow Text to wrap
                          Text(
                            'amount : ${users[index]['amount'].toString()}',
                            textAlign: TextAlign.left,
                            overflow: TextOverflow
                                .ellipsis, // Optional: add ellipsis for overflow
                            maxLines: 3, // Limit to 3 lines
                          ),
                          SizedBox(height: 10),
                          Text(
                            'qty : ${users[index]['qty'].toString()}',
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 10),
                          // Remove FittedBox and allow Text to wrap
                          Text(
                            'Total Price (including GST): \$${totalPrice.toStringAsFixed(2)}',
                            textAlign: TextAlign.left,
                            overflow: TextOverflow
                                .ellipsis, // Optional: add ellipsis for overflow
                            maxLines: 3, // Limit to 3 lines
                          ),
                        ],
                      ),
                    ),
                    // Use the Col widget
                    Column(
                      children: [
                        TextButton(
                            onPressed: () {
                              _bottemsheetEdit(
                                users[index]['name'].toString(),
                                users[index]['number'].toString(),
                                users[index]['id'].toString(),
                                users[index]['amount'].toString(),
                                users[index]['qty'].toString(),
                                totalPrice.toStringAsFixed(2),
                              );
                            },
                            child: Icon(Icons.edit)),
                        TextButton(
                            onPressed: () {
                              ref.doc(users[index]['id'].toString()).delete();
                            },
                            child: Icon(Icons.delete)),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => viewAllDetails()));
                            },
                            child: Icon(Icons.remove_red_eye_outlined)),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),

ElevatedButton(
  onPressed: () {
    sendEmail();
  },
  child: Text('Send Email'),
)

        ],
      ),
    );
  }
  Future<void> sendEmail() async {
  final Email email = Email(
    body: 'This is a test email sent from my Flutter app.',
    subject: 'Test Email',
    recipients: ['ivontechhub@gmail.com'], // Replace with the recipient's email
    // cc: ['cc@example.com'], // Optional
    // bcc: ['bcc@example.com'], // Optional
    // attachmentPaths: [], // Optional: List of file paths to attach
    // isHTML: false, // Set to true if the body is HTML
  );

  try {
    await FlutterEmailSender.send(email);
    print('Email sent successfully');
  } catch (error) {
    print('Error sending email: $error');
  }
}

  Future _bottemsheet() {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        context: context,
        builder: (context) => Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        labelText: 'Name ', border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextFormField(
                    controller: numberController,
                    decoration: InputDecoration(
                        labelText: 'Number ', border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: amoutController,
                    decoration: InputDecoration(
                        labelText: 'amount', border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: qtyController,
                    decoration: InputDecoration(
                        labelText: 'qty', border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RoundedButton(
                      loading: loading,
                      text: "add post",
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => fireStore()));
                        setState(() {
                          loading = true;
                        });
                        String id =
                            DateTime.now().microsecondsSinceEpoch.toString();
                        firestore.doc(id).set({
                          'id': id,
                          'name': nameController.text.toString(),
                          'number': numberController.text.toString(),
                          'amount': double.parse(amoutController.text),
                          'qty': int.parse(qtyController.text),
                          'total': totalPrice.toStringAsFixed(2),
                          'timestamp': Timestamp.now(),
                          'date':
                              DateTime.now().toIso8601String().split('T')[0],
                        }).then((value) {
                          setState(() {
                            loading = false;
                          });
                        }).onError((error, StackTrace) {
                          setState(() {
                            loading = false;
                          });
                        });
                        Navigator.of(context).pop();
                      }),
                )
              ],
            ));
  }

  Future _bottemsheetEdit(String title, String number, String id, String amount,
      String qty, String total) {
    nameEdit.text = title;
    numberEdit.text = number;
    amoutEdit.text = amount;
    qtyEdit.text = qty;
    totalEdit.text = total;
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        context: context,
        builder: (context) => Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextFormField(
                    controller: nameEdit,
                    decoration: InputDecoration(
                        labelText: 'Name ', border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextFormField(
                    controller: numberEdit,
                    decoration: InputDecoration(
                        labelText: 'number ', border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextFormField(
                    controller: amoutEdit,
                    decoration: InputDecoration(
                        labelText: 'amount', border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextFormField(
                    controller: qtyEdit,
                    decoration: InputDecoration(
                        labelText: 'qty', border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RoundedButton(
                    loading: loading,
                    text: "Updated post",
                    onPressed: () {
                      // Update the document and close the dialog
                      ref.doc(id).update({
                        'name': nameEdit.text.toString(),
                        'number': numberEdit.text.toString(),
                        'amount': amoutEdit.text.toString(),
                        'qty': qtyEdit.text.toString(),
                        // 'total': totalEdit.text.toString(),
                      }).then((value) {
                        // Optionally, you can show a success message here
                      }).onError((error, stackTrace) {
                        // Handle the error here
                      });

                      // Close the dialog
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ));
  }

//   Future<void> showMyDialog(

//       String title, String id, String amount, String qty, String total) async {
//     nameEdit.text = title;
//     amoutEdit.text = amount;
//     qtyEdit.text = qty;
//     totalEdit.text = total;
//     // Show the dialog and wait for it to close
//     await showDialog(
//       context: context,
//       builder: (BuildContext dialogContext) {
//         return AlertDialog(
//           title: Text("Update"),
//           content: Column(
//             children: [
//               TextFormField(
//                 controller: nameEdit,
//                 decoration: InputDecoration(
//                   hintText: "Edit name",
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               TextFormField(
//                 controller: amoutEdit,
//                 decoration: InputDecoration(
//                   hintText: "Edit amout",
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               TextFormField(
//                 controller: qtyEdit,
//                 decoration: InputDecoration(
//                   hintText: "Edit qty",
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               TextFormField(
//                 controller: totalEdit,
//                 decoration: InputDecoration(
//                   hintText: "Edit total",
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 // Close the dialog
//                 Navigator.of(dialogContext).pop();
//               },
//               child: Text("Cancel"),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Update the document and close the dialog
//                 ref.doc(id).update({
//                   'name': nameEdit.text.toString(),
//                   'amount': amoutEdit.text.toString(),
//                   'qty': qtyEdit.text.toString(),
//                   'total': totalEdit.text.toString(),
//                 }).then((value) {
//                   // Optionally, you can show a success message here
//                 }).onError((error, stackTrace) {
//                   // Handle the error here
//                 });
  Future<void> calculateTotalPrice() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .get();

    double subtotal = 0.0;

    for (var doc in snapshot.docs) {
      double price = (doc['amount'] ?? 0.0).toDouble(); // Ensure price is double
      int quantity = (doc['qty'] ?? 0).toInt();        // Ensure quantity is int

      subtotal += price * quantity; // Accumulate the total
    }

    print('Total Price: $subtotal');
  }

//                 // Close the dialog
//                 Navigator.of(dialogContext).pop();
//               },
//               child: Text("Update"),
//             ),
//           ],
//         );
//       },
//     );
//   }
}
