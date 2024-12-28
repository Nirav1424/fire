import 'package:fire/favriout/favouriteProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favriout extends StatefulWidget {
  const Favriout({super.key});

  @override
  State<Favriout> createState() => _FavrioutState();
}

class _FavrioutState extends State<Favriout> {
  @override
  Widget build(BuildContext context) {
    print("build");
    // final provider = Provider.of<Favouriteprovider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("favriout"),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return Consumer<Favouriteprovider>(
                        builder: (context, value, child) {
                      return ListTile(
                        onTap: () {
                          if (value.selected.contains(index)) {
                            value.removeItem(index);
                          } else {
                            value.addItem(index);
                          }
                        },
                        title: Text('item ' + index.toString()),
                        trailing: Icon(
                          value.selected.contains(index)
                              ? Icons.favorite
                              : Icons.favorite_outline,
                        ),
                      );
                    });
                  }))
        ],
      ),
    );
  }
}
