import 'package:flutter/material.dart';

class Fav extends StatelessWidget {
  final List<int> selected;
   Fav({super.key , required this.selected});

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
                },
                icon: Icon(Icons.favorite)),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: selected.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      onTap: () {
                      if (selected.contains(index)) {
                        selected.remove(index);
                      } else {
                        selected.add(index);
                      }

                      
                    },
                    title: Text('index' + selected[index].toString()),
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
