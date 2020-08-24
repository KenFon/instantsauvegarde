import 'package:flutter/material.dart';
import 'package:instant_beta/Screens/Events/EventPage.dart';
import 'package:instant_beta/Screens/Profile/ProfilPage.dart';
import 'package:instant_beta/main.dart';

import '../Widgets/BottomNavBar.dart';

//import des différentes pages
import 'Utils/CommingSoonPage.dart';
import 'Settings/SettingsPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key:key);
  final String title;

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int currentTab = 0;
  PageController pageController;
  String _lastSelected = 'TAB: 0';

  _changeCurrenTab(int tab) {
    setState(() {
      currentTab = tab;
      pageController.jumpToPage(0);
    });
  }

  void _selectedTab(int index) {
    setState(() {
      _lastSelected = 'TAB: $index';
    });
  }

  @override
  void initState() {
    super.initState();
    pageController = new PageController();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: bodyView(currentTab),
        bottomNavigationBar: BottomAppBarCustom(
            changeCurrentTab: _changeCurrenTab,
            centerItemText: "Photos",
            color: Colors.grey,
            selectedColor: Colors.red,
            notchedShape: CircularNotchedRectangle(),
            onTabSelected: _selectedTab,
            items: [
              BottomAppBarCustomItem(iconData: Icons.home, text:"Accueil"),
              BottomAppBarCustomItem(iconData: Icons.event, text:"Evenement"),
              BottomAppBarCustomItem(iconData: Icons.person, text:"Profil"),
              BottomAppBarCustomItem(iconData: Icons.settings, text:"Paramétre"),
            ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: 'test',
          child: Icon(Icons.add_a_photo),
          elevation: 2.0,
        ),
      )
    );
  }



  bodyView(currentTab) {
    List<Widget> tabView = [];
    //Current Tabs in Home Screen...
    switch (currentTab) {
      case 0:
      //Dashboard Page
        tabView = [PageComingSoon()];
        break;
      case 1:
      //Event Page
        tabView = [EventPage()];
        break;
      case 2:
      //Profile Page
        tabView = [ProfilePage()];
        break;
      case 3:
      //Setting Page
        tabView = [SettingPage()];
        break;
    }
    return PageView(controller: pageController, children: tabView);
  }
}



