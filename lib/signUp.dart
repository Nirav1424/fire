import 'package:fire/custom/roundedButton.dart';
import 'package:fire/loadingProvider.dart';
import 'package:fire/login.dart';
import 'package:fire/toggleProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class signUp extends StatefulWidget {
  const signUp({super.key});

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    print("build signup");
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: const Text("Sign Up From"),
        backgroundColor: Colors.deepPurple,
      ),
      // ignore: prefer_const_constructors

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Container(
          //   child: const Text(
          //     "Sign UP Form",
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
                      return (value == null) ? 'Do not use the @ char.' : null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Consumer<Toggleprovider>(
                  builder: (context, value, child) {
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
                      obscureText: value.hidindata, // This hides the text input
                    ),
                  );
                }),
                SizedBox(height: 10),
                Consumer<Loadingprovider>(
                  builder: (context, value, child) {
                    return RoundedButton(
                        text: "sign UP",
                        loading: value.loading,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            value.setLoading(true);
                
                            auth
                                .createUserWithEmailAndPassword(
                                    email: emailController.text.toString(),
                                    password:
                                        passwordController.text.toString())
                                .then((val) {
                             value.setLoading(false);
                            }).onError((error, StackTrace) {
                             value.setLoading(false);
                            });
                          }
                        });
                  },
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
              Text("do you have alredy accounts ?"),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => login()),
                    );
                  },
                  child: const Text("login"))
            ],
          )
        ],
      ),
    );
  }
}
