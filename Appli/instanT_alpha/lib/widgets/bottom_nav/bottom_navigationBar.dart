import 'package:flutter/material.dart';
import '../../utils/utils.dart';

class BottomNavBar extends StatefulWidget {
  final ValueChanged<int> changeCurrentTab;

  BottomNavBar({Key key, this.changeCurrentTab}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with SingleTickerProviderStateMixin {
  int tab = 0;

  Screen size;

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      iconSize: size.getWidthPx(24),
      currentIndex: tab,
      unselectedItemColor: Colors.black45,
      selectedItemColor: colorCurve,
      elevation: 150.0,
      selectedFontSize: 15.0,
      showUnselectedLabels: true,
      onTap: (int index) {
        setState(() {
          if (index != 4) {
            tab = index;
            widget.changeCurrentTab(index);
          }
        });
      },
      items: [
        BottomNavigationBarItem(
          backgroundColor: Colors.grey.shade50,
          icon: Icon(Icons.home),
          title: Text('Accueil', style: TextStyle(fontFamily: 'Exo2')),
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.grey.shade50,
          icon: Icon(Icons.add_a_photo),
          title: Text('Appareil photo', style: TextStyle(fontFamily: 'Exo2')),
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.grey.shade50,
          icon: Icon(Icons.person),
          title: Text('Profil', style: TextStyle(fontFamily: 'Exo2')),
        ),
      ],
    );
  }
}
