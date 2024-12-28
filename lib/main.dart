import 'package:fire/Apis/Api.dart';
import 'package:fire/DarkTheme.dart';
import 'package:fire/bottomSheet.dart';
import 'package:fire/colorProvider.dart';
import 'package:fire/count_provider.dart';
import 'package:fire/count_example.dart';
import 'package:fire/day2/favrout.dart';
import 'package:fire/day2/task1/containerpb.dart';
import 'package:fire/day2/task1/task2/listcardpb.dart';
import 'package:fire/exampleColorProvider.dart';
import 'package:fire/favriout/favouriteProvider.dart';
import 'package:fire/favriout/favriout.dart';
import 'package:fire/loadingProvider.dart';
import 'package:fire/login.dart';
import 'package:fire/splace/spaceScreen.dart';
import 'package:fire/themeProvider.dart';
import 'package:fire/toggleProvider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
    options:  FirebaseOptions(
    apiKey: 'AIzaSyDLVC_3_2NpFemKrydBbMEQZ47-xUo65C4',
    appId: '1:864669987106:android:00f10178ef0057f689f57b',
    messagingSenderId: '864669987106',
    projectId: 'hellofire-d7946',
    storageBucket: 'hellofire-d7946.firebasestorage.app',
    databaseURL: 'https://hellofire-d7946-default-rtdb.firebaseio.com/' 
  ),

// authDomain: 'fir-practiceapp-75387.firebaseapp.com
// storageBucket: fir-practiceapp-75387.appspot.com.

  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CountProvider()),
          ChangeNotifierProvider(create: (_) => ExampleColorProvider()),
          ChangeNotifierProvider(create: (_) => Favouriteprovider()),
          ChangeNotifierProvider(create: (_) => themeProvider()),
          ChangeNotifierProvider(create: (_) => Toggleprovider()),
          ChangeNotifierProvider(create: (_) => Loadingprovider()),


        ],
        child: Builder(builder: (BuildContext context) {
          final themeChanger = Provider.of<themeProvider>(context);
          return MaterialApp(
            
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            themeMode: themeChanger.themeMode,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
            ),
            
            // home: Favrout(),
            home: splaceScreen(),
            // home: Bottomsheet(),
            // home: api(),
          );
        }));
  }
}
