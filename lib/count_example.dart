import 'dart:async';

import 'package:fire/count_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class provider extends StatefulWidget {
  const provider({super.key});

  @override
  State<provider> createState() => _providerState();
}

class _providerState extends State<provider> {
  @override
  void initState() {
    final Countprovider = Provider.of<CountProvider>(context, listen: false);
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(seconds: 2), (timer) {
      Countprovider.setCount();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Countprovider = Provider.of<CountProvider>(context, listen: false);
    print("build");
    return Scaffold(
      appBar: AppBar(title: Text('provider')),
      body: Center(
          child: Consumer<CountProvider>(builder: (context, value, child) {
        // print("only this build");
        return Text(
          value.count.toString(),
          style: TextStyle(fontSize: 30),
        );
      })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Countprovider.setCount();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
