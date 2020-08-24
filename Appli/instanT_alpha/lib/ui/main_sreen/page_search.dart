import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../model/models.dart';
import '../../utils/utils.dart';
import '../../widgets/widgets.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Screen size;
  int _selectedIndex = 1;

  List<Property> premiumList =  List();
  List<Property> featuredList =  List();
  var categoriesList = ["Général", "Défis"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    premiumList
    ..add(Property(propertyName:"Omkar Lotus", propertyLocation:"Ginette", image:"https://picsum.photos/200/150", propertyPrice:"26.5 Cr"))
    ..add(Property(propertyName:"Sandesh Heights", propertyLocation:"Bernard", image:"https://picsum.photos/200/150", propertyPrice:"11.5 Cr"))
    ..add(Property(propertyName:"Sangath Heights", propertyLocation:"Ken", image:"https://picsum.photos/200/150", propertyPrice:"19.0 Cr"))
    ..add(Property(propertyName:"Adani HighRise", propertyLocation:"Christophe ", image:"https://picsum.photos/200/150", propertyPrice:"22.5 Cr"))
    ..add(Property(propertyName:"N.G Tower", propertyLocation:"Marius ", image:"https://picsum.photos/200/150", propertyPrice:"7.5 Cr"))
    ..add(Property(propertyName:"Vishwas CityRise", propertyLocation:"truc ", image:"https://picsum.photos/200/150", propertyPrice:"17.5 Cr"))
    ..add(Property(propertyName:"Gift City", propertyLocation:"bidule ", image:"https://picsum.photos/200/150", propertyPrice:"13.5 Cr"))
    ..add(Property(propertyName:"Velone City", propertyLocation:"tête de cul ", image:"https://picsum.photos/200/150", propertyPrice:"11.5 Cr"))
    ..add(Property(propertyName:"PabelBay", propertyLocation:"mohamed ", image:"https://picsum.photos/200/150", propertyPrice:"33.1 Cr"))
    ..add(Property(propertyName:"Sapath Hexa Tower", propertyLocation:"TO DO remplace string", image:"https://picsum.photos/200/150", propertyPrice:"15.6 Cr"));



  }

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(
            statusBarColor: backgroundColor,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: backgroundColor),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[upperPart()],
            ),
          ),
        ),
      ),
    );
  }

  Widget upperPart() {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: UpperClipper(),
          child: Container(
            height: size.getWidthPx(240),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colorCurve, colorCurveSecondary],
              ),
            ),
          ),
        ),
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: size.getWidthPx(36)),
              child: Column(
                children: <Widget>[
                  titleWidget(),
                  SizedBox(height: size.getWidthPx(10)),
                  upperBoxCard(),
                ],
              ),
            ),
            leftAlignText(
                text: "Photos de l'événement",
                leftPadding: size.getWidthPx(16),
                textColor: textPrimaryColor,
                fontSize: 16.0),
            HorizontalList(
              children: <Widget>[
                for (int i = 0; i < premiumList.length; i++)
                  photosCard(premiumList[i], true)
              ],
            ),
            leftAlignText(
                text: "Mes photos",
                leftPadding: size.getWidthPx(16),
                textColor: textPrimaryColor,
                fontSize: 16.0),
            HorizontalList(
              children: <Widget>[
                for (int i = 0; i < premiumList.length; i++)
                  photosCard(premiumList.reversed.toList()[i], false)

              ],
            )
          ],
        ),
      ],
    );
  }

  Text titleWidget() {
    return Text("Votre évemenement",
        style: TextStyle(
            fontFamily: 'Exo2',
            fontSize: 24.0,
            fontWeight: FontWeight.w900,
            color: Colors.white));
  }

  Card upperBoxCard() {
    return Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        margin: EdgeInsets.symmetric(
            horizontal: size.getWidthPx(20), vertical: size.getWidthPx(16)),
        borderOnForeground: true,
        child: Container(
          height: size.getWidthPx(150),
          child: Column(
            children: <Widget>[
              //_searchWidget(),
              leftAlignText(
                  text: "Mariage de bidule",
                  leftPadding: size.getWidthPx(63),
                  textColor: textPrimaryColor,
                  fontSize: 25.0,
                  margin: EdgeInsets.all(5)),
              leftAlignText(
                  text: "Welcome dans le mariage de bidule, c'est ma meilleure journée alors faite pas de la merde svp ça serai cool ! ",
                  leftPadding: size.getWidthPx(16),
                  textColor: textPrimaryColor,
                  fontSize: 13.0,
                  margin: EdgeInsets.all(1)),
              leftAlignText(
                  text: "Photos",
                  leftPadding: size.getWidthPx(130),
                  textColor: textPrimaryColor,
                  fontSize: 17.0,
                  margin: EdgeInsets.only(top: 7)),
              HorizontalList(
                children: <Widget>[
                  for(int i=0;i<categoriesList.length;i++)
                    buildChoiceChip(i, categoriesList[i])
                ],
              ),
            ],
          ),
        ));
  }

  BoxField _searchWidget() {
    return BoxField(
        controller: TextEditingController(),
        focusNode: FocusNode(),
        hintText: "Select by city, area or locality.",
        lableText: "Search...",
        obscureText: false,
        onSaved: (String val) {},
        icon: Icons.search,
        iconColor: colorCurve);
  }

// ############### Mini Widget pour le formatage des textes ###################
  Container leftAlignText({text, leftPadding, textColor, fontSize, fontWeight, margin}) {
    return Container (
        margin: margin,
        child: Padding(
          padding: EdgeInsets.only(left: leftPadding),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(text??"",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Exo2',
                    fontSize: fontSize,
                    fontWeight: fontWeight ?? FontWeight.w500,
                    color: textColor)),
          ),
        )
    );
  }

  // ############### Mini Widget pour l'affichage des photos ###################
  Card photosCard(Property property, bool userName) {
    return Card(
        elevation: 4.0,
        margin: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        borderOnForeground: true,
        child: Container(
            height: size.getWidthPx(150),
            width: size.getWidthPx(170),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0)),
                    child: Image.network(property.image,
                        fit: BoxFit.fill)),
                SizedBox(height: size.getWidthPx(5)) ,
                leftAlignText(
                    text: userName ? property.propertyLocation : "date de la photo",
                    leftPadding: size.getWidthPx(8),
                    textColor: Colors.black54,
                    fontSize: 12.0),
                SizedBox(height: size.getWidthPx(1)),
              ],
            )));
  }

// ############# Mini Widget pour le choix du type de photo  ###################
  Padding buildChoiceChip(index, chipName) {
    return Padding(
      padding: EdgeInsets.only(left: size.getWidthPx(8)),
      child: ChoiceChip(
        backgroundColor: backgroundColor,
        selectedColor: colorCurve,
        labelStyle: TextStyle(
            fontFamily: 'Exo2',
            color:
                (_selectedIndex == index) ? backgroundColor : textPrimaryColor),
        elevation: 4.0,
        padding: EdgeInsets.symmetric(
            vertical: size.getWidthPx(4), horizontal: size.getWidthPx(12)),
        selected: (_selectedIndex == index) ? true : false,
        label: Text(chipName),
        onSelected: (selected) {
          if (selected) {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
      ),
    );
  }
}
