import 'package:flutter/material.dart';

class BottomAppBarCustomItem {
  BottomAppBarCustomItem({ this.iconData, this.text});
  IconData iconData;
  String text;
}

class BottomAppBarCustom extends StatefulWidget {
  BottomAppBarCustom({
    this.items,
    this.centerItemText,
    this.height: 60.0,
    this.iconSize: 24.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.notchedShape,
    this.onTabSelected,
    this.changeCurrentTab,
}) {
    assert(this.items.length == 2 || this.items.length == 4);
  }
  final List<BottomAppBarCustomItem> items;
  final String centerItemText;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;
  final ValueChanged<int> changeCurrentTab;

  @override
  State<StatefulWidget> createState() => BottomAppBarCustomState();
}

class BottomAppBarCustomState extends State<BottomAppBarCustom> {
  int _selectedIndex = 0;
  int tab = 0;

  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
      tab = index;
      widget.changeCurrentTab(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });
    items.insert(items.length >> 1, _buildMiddleTabItem());

    return BottomAppBar(
      shape: widget.notchedShape,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
      color: widget.backgroundColor,
    );
  }

  //****************************************************************************
  //             Def des mini Widget pour construire le menu
  //***************************************************************************
  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: widget.iconSize),
            Text(
              widget.centerItemText ?? '',
              style: TextStyle(color: widget.color),
            ),
          ],
        )
      ),
    );
  }

  Widget _buildTabItem({
    BottomAppBarCustomItem item,
    int index,
    ValueChanged<int> onPressed,
}) {
    Color color = _selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(item.iconData, color: color, size: widget.iconSize),
                Text(
                  item.text,
                  style: TextStyle(color: color),
                )
              ],
            )
          ),
        )
      ),
    );
  }
}