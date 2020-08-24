import 'dart:async';
import 'package:flutter/material.dart';

//import des utilitaires
import '../../Utils/LocalBindings.dart';
import '../../Utils/Constants.dart';
import '../../Utils/responsive_screen.dart';

//import des pages
import '../Auth/Login.dart';
import 'Walkthrough.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Screen size;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      navigateFromSplash();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: size.getWidthPx(300),
          height: size.getWidthPx(300),
          child: Image.asset("assets/images/logo_splash.png")
        )  
      )
    );
  }



  Future navigateFromSplash () async {

    String isOnBoard = await LocalStorage.sharedInstance.readValue(Constants.isOnBoard);
    print("isOnBoard  $isOnBoard");
    if(isOnBoard ==null || isOnBoard == "0"){
      //Navigate to OnBoarding Screen.
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Walkthrough()));
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }
}