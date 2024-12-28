import 'package:flutter/material.dart';

class Listcardpb extends StatefulWidget {
  const Listcardpb({super.key});

  @override
  State<Listcardpb> createState() => _ListcardpbState();
}

class _ListcardpbState extends State<Listcardpb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: List.generate(3, (index) {
          return Container(
            width: MediaQuery.of(context).size.width *
                8, // Set a width for the card
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
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
                                'Name: Nirav Asodariya',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              // Remove FittedBox and allow Text to wrap
                              Text(
                                'The Card widget in Flutter is a versatile and easy-to-use component for displaying information in a visually appealing way. You can customize it with various properties and child widgets to fit.',
                                textAlign: TextAlign.left,
                                overflow: TextOverflow
                                    .ellipsis, // Optional: add ellipsis for overflow
                                maxLines: 3, // Limit to 3 lines
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Amount: 100000',
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                        // Use the Col widget
                        Column(
                          children: [
                            TextButton(
                                onPressed: () {}, child: Icon(Icons.edit)),
                            TextButton(
                                onPressed: () {}, child: Icon(Icons.delete)),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
