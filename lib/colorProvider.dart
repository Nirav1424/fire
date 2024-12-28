import 'package:fire/exampleColorProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class colorProvider extends StatefulWidget {
  const colorProvider({super.key});

  @override
  State<colorProvider> createState() => _colorProviderState();
}

class _colorProviderState extends State<colorProvider> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ExampleColorProvider>(context, listen: false);
    print("build");
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<ExampleColorProvider>(builder: (context, value, child) {
            return Slider(
                min: 0,
                max: 1,
                value: value.value,
                onChanged: (val) {
                  provider.setValue(val);
                });
          }),
          Consumer<ExampleColorProvider>(builder: (context, value, child) {
            return Row(
              children: [
                Expanded(
                    child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(value.value),
                  ),
                  child: const Center(
                    child: Text(
                      "container 1",
                    ),
                  ),
                )),
                Expanded(
                    child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(value.value),
                  ),
                  child: const Center(
                    child: Text(
                      "container 2",
                    ),
                  ),
                )),
              ],
            );
          })
        ],
      ),
    );
  }
}
