import 'package:fire/custom/roundedButton.dart';
import 'package:fire/firestore.dart';
import 'package:fire/loadingProvider.dart';
import 'package:fire/post.dart';
import 'package:fire/signUp.dart';
import 'package:fire/toggleProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final auth = FirebaseAuth.instance;
  bool loading = false;

  Future<void> login() async {}

  @override
  Widget build(BuildContext context) {
    print("build login");
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: const Text("Login From"),
          backgroundColor: Colors.deepPurple,
        ),
        // ignore: prefer_const_constructors

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Container(
            //   child: const Text(
            //     "Login Form",
            //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            //   ),
            // ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: const InputDecoration(
                          // icon: Icon(Icons.person),
                          // hintText: 'username',
                          labelText: 'Name ',
                          suffixIcon: Icon(Icons.verified_user)),
                      validator: (String? value) {
                        return (value == null)
                            ? 'Do not use the @ char.'
                            : null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Consumer<Toggleprovider>(builder: (context, value, child) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            icon: value.hidindata
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons
                                    .visibility_off), // Change icon based on visibility
                            onPressed: () {
                              value.setBool(value.hidindata);
                            },
                          ),
                        ),
                        obscureText:
                            value.hidindata, // This hides the text input
                      ),
                    );
                  }),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Consumer<Loadingprovider>(
                      builder: (context, value, child) {
                        return RoundedButton(
                            text: "login",
                            loading: value.loading,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                value.setLoading(true);
                                auth
                                    .signInWithEmailAndPassword(
                                        email: emailController.text.toString(),
                                        password:
                                            passwordController.text.toString())
                                    .then((val) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (Context) => fireStore()));
                                  value.setLoading(false);
                                  debugPrint(value.toString());
                                }).onError((error, StackTrace) {
                                  value.setLoading(false);
                                  debugPrint(error.toString());
                                });
                              }
                            });
                      },
                    ),
                  ),
                ],
              ),
            ),

            // ignore: prefer_const_constructors
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("does not have any accounts ?"),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => signUp()),
                      );
                    },
                    child: const Text("Sign Up"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
  
  // @override
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //   throw UnimplementedError();
  // }

