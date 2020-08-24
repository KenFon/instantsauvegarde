import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../Utils/Constants.dart';
import '../Auth/Login.dart';
import 'package:instant_beta/Utils/LocalBindings.dart';

class Walkthrough extends StatefulWidget {
  @override
  _WalkthroughState createState() => _WalkthroughState();
}

class _WalkthroughState extends State<Walkthrough> {

  List pageInfos = [
    {
      "title": "Vivez vos meilleurs moments",
      "body": "Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus."
          " Vestibulum ac diam sit amet quam vehicula elementum sed sit amet "
          "dui. Nulla porttitor accumsan tincidunt.",
      "img": "assets/on1.png",
    },
    {
      "title": "Souriez, vous êtes photographier",
      "body": "Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus."
          " Vestibulum ac diam sit amet quam vehicula elementum sed sit amet "
          "dui. Nulla porttitor accumsan tincidunt.",
      "img": "assets/on2.png",
    },
    {
      "title": "Recupérez toutes les photos !",
      "body": "Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus."
          " Vestibulum ac diam sit amet quam vehicula elementum sed sit amet "
          "dui. Nulla porttitor accumsan tincidunt.",
      "img": "assets/on3.png",
    },
  ];
  @override
  Widget build(BuildContext context){
    List<PageViewModel> pages = [
      for(int i=0; i<pageInfos.length; i++)
        _buildPageModel(pageInfos[i])
    ];

    return WillPopScope(
      onWillPop: ()=>Future.value(false),
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: IntroductionScreen(
            pages: pages,
            onDone: () async{
              LocalStorage.sharedInstance.writeValue(key:Constants.isOnBoard,value: "1");
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
            },
            onSkip: () {
              LocalStorage.sharedInstance.writeValue(key:Constants.isOnBoard,value: "1");
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
            },
            showSkipButton: true,
            skip: Text('Passer'),
            next: Text('Suivant', style: TextStyle(fontWeight: FontWeight.w800, color: Theme.of(context).accentColor)),
            done: Text('Terminer', style:TextStyle(fontWeight: FontWeight.w800, color: Theme.of(context).accentColor))
          ),
        ),
      ),
    );
  }





  //Construction d'une page d'intro
  _buildPageModel(Map item){
    return PageViewModel(
      title: item['title'],
      body: item['body'],
      image: Image.asset(
        item['img'],
        height: 185.0,
      ),
      decoration: PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).accentColor,
        ),
        bodyTextStyle: TextStyle(fontSize: 15.0),
//        dotsDecorator: DotsDecorator(
//          activeColor: Theme.of(context).accentColor,
//          activeSize: Size.fromRadius(8),
//        ),
        pageColor: Theme.of(context).primaryColor,
      ),
    );
  }
}