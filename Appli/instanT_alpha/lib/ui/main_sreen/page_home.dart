import 'package:flutter/material.dart';
import 'package:instanT_alpha/widgets/bottom_nav/bottom_bar_view.dart';
import '../../widgets/bottom_nav/bottom_navigationBar.dart';
import '../../LocalBindings.dart';
import '../../utils/Constants.dart';


import '../utils_screen/page_coming_soon.dart';
import '../profile_screen/page_profile.dart';
import 'page_search.dart';
import '../settings_screen/page_settings.dart';
import '../../model/tabIcon_data.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  PageController pageController;
  String currentTab = "0";
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  _changeCurrentTab(int tab) async {
    currentTab = await LocalStorage.sharedInstance.readValue(Constants.currentTab);
    String setCurrentTab = tab.toString();
    print(setCurrentTab);
    //Changing tabs from BottomNavigationBar
    setState(() {
      currentTab = setCurrentTab;
      pageController.jumpToPage(0);
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = new PageController();
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: bodyView(currentTab),
          bottomNavigationBar: BottomBarView(changeIndex: _changeCurrentTab)),
    );
  }
}






















