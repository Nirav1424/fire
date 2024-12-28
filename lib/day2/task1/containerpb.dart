import 'package:flutter/material.dart';

class BoxGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Create a list of 100 items (you can change this number)
    final int itemCount = 10;

    return ListView(
      scrollDirection: Axis.horizontal,
      children:[
        Wrap(
        spacing: 4.0, // Space between boxes horizontally
        runSpacing: 4.0, // Space between boxes vertically
        children: List.generate(itemCount, (index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 50,
              height: 50,
              color: Colors.amber, // Different shades of blue
             
            ),
          );
        }),
      ),
      ] 
    );
  }
}