import 'package:fire/splace/spalceServices.dart';
import 'package:flutter/material.dart';

class splaceScreen extends StatefulWidget {
  const splaceScreen({super.key});

  @override
  State<splaceScreen> createState() => _splaceScreenState();
}

class _splaceScreenState extends State<splaceScreen> {
  Spalceservices ss = Spalceservices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ss.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("splace screen",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
      ),
    );
  }
}
