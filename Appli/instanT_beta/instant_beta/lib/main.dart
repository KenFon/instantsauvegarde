import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Screens/onBoarding/Splash.dart';
import 'Screens/homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'InstanT',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (context, userSnapshot) {
            if(userSnapshot.hasData){
              return HomePage();
            }
            return SplashScreen();
          },
        )
      //CollectionApp(),
    );
  }
}