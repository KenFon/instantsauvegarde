import 'package:flutter/material.dart';
import '../Utils/responsive_screen.dart';

class HorizontalList extends StatefulWidget {
  final List<Widget> children;
  final ScrollPhysics scrollPhysics;

  const HorizontalList({Key key, this.children, this.scrollPhysics}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HorizontalListState();
}

class _HorizontalListState extends State<HorizontalList> {
  Screen size;

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);

    return Container(
      padding: EdgeInsets.all(size.getWidthPx(4)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: ClampingScrollPhysics(),
        child: Row(
          children: widget.children,
        ),
      ),
    );
  }
}