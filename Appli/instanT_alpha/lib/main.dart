import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'ui/utils_screen/page_splash.dart';
import 'ui/main_sreen/page_home.dart';

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



class CollectionApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Theme.of(context).primaryColor,
        ),
        home: SplashScreen()
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}




