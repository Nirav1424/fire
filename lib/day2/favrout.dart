import 'package:fire/fav.dart';
import 'package:flutter/material.dart';

class Favrout extends StatefulWidget {
  const Favrout({super.key});

  @override
  State<Favrout> createState() => _FavroutState();
}

class _FavroutState extends State<Favrout> {
  List<int> selected = [];
  // bool like = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("favroiut"),
        backgroundColor: Colors.blueAccent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
                onPressed: () {
                  // Navigate to the Second Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Fav(selected: selected)),
                  );
                },
                icon: Icon(Icons.favorite)),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      if (selected.contains(index)) {
                        selected.remove(index);
                      } else {
                        selected.add(index);
                      }

                      setState(() {});
                    },
                    title: Text('index ' + index.toString()),
                    trailing: selected.contains(index)
                        ? Icon(Icons.favorite)
                        : Icon(Icons.favorite_border),
                  );
                }),
          )
        ],
      ),
    );
  }
}
