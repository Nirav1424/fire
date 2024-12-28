import 'package:fire/custom/roundedButton.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int myIndex = 0;
  List<Widget> list =const [
    Text('home ',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
    Text('music',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
    Text('setting',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
                    
                    IndexedStack(
                      children: list,
                      index: myIndex,
                    ),
             
              
           
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // backgroundColor: Colors.black,
          onTap: (idx) {
            setState(() {
              myIndex = idx;
            });
          },
          currentIndex: myIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home,color: Colors.green,), label: "home",),
            BottomNavigationBarItem(
                icon: Icon(Icons.music_note,color: Colors.green), label: "music"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings,color: Colors.green), label: "settings"),
          ]),
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(context,
              // MaterialPageRoute(builder: (context) => Bottomsheet()));
        },
        backgroundColor: Colors.deepPurple,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

 
}
