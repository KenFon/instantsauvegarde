import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//Import des widgets
import '../../Widgets/settings_section.dart';
import '../../Widgets/title_row.dart';
import '../../Widgets/switch_row.dart';

//Import des utilitaires
import '../../Utils/colors.dart';
import '../../Utils/LocalBindings.dart';
import '../../Utils/Constants.dart';

class SettingPage extends StatefulWidget {
  final ValueChanged<int> changeCurrentTab;

  SettingPage({Key key, this.changeCurrentTab}) : super(key: key);
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isLocalNotification = false;
  bool isPushNotification = true;
  bool isPrivateAccount = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Paramètre",
            style:
            TextStyle(fontFamily: "Exo2", color: textSecondaryLightColor)),
        backgroundColor: Colors.white,
      ),
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(
            statusBarColor: backgroundColor,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarIconBrightness: Brightness.light,
            systemNavigationBarColor: backgroundColor),
        child: Container(
          color: backgroundColor,
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: <Widget>[
                accountSection(),
                pushNotificationSection(),
                getHelpSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SettingSection getHelpSection() {
    return SettingSection(
      headerText: "Aide".toUpperCase(),
      headerFontSize: 15.0,
      headerTextColor: Colors.black87,
      backgroundColor: Colors.white,
      disableDivider: false,
      children: <Widget>[
        Container(
          child: TileRow(
            label: "Contactez nous",
            disableDivider: false,
            onTap: () {},
          ),
        ),
        Container(
          child: TileRow(
            label: "Conditions d'utilisations",
            disableDivider: false,
            onTap: () {},
          ),
        ),
        Container(
          child: TileRow(
            label: "Votre avis compte",
            disableDivider: false,
            onTap: () {},
          ),
        ),
        Container(
          child: TileRow(
            label: "Se déconnecter",
            disableDivider: false,
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        )
      ],
    );
  }

  SettingSection accountSection() {
    return SettingSection(
      headerText: "Compte".toUpperCase(),
      headerFontSize: 15.0,
      headerTextColor: Colors.black87,
      backgroundColor: Colors.white,
      disableDivider: false,
      children: <Widget>[
        Container(
          child: TileRow(
            label: "Nom d'utilisateur",
            disabled: true,
            rowValue: "Ken",
            disableDivider: false,
            onTap: () {},
          ),
        ),
        Container(
          child: TileRow(
            label: "Mon Profil",
            disableDivider: false,
            onTap: () async {
              LocalStorage.sharedInstance.writeValue(key:Constants.currentTab,value: "3");
              widget.changeCurrentTab(3);
              String test = await LocalStorage.sharedInstance.readValue(Constants.currentTab);
              print("currentTab $test");
            },
          ),
        ),
        Container(
          child: TileRow(
            label: "Modifier mon mot de passe",
            disableDivider: false,
            onTap: () {},
          ),
        ),
        Container(
          child: SwitchRow(
            label: "Mes évenements",
            disableDivider: false,
            value: isPrivateAccount,
            onSwitchChange: (switchStatus) {
              setState(() {
                switchStatus
                    ? isPrivateAccount = true
                    : isPrivateAccount = false;
              });
            },
            onTap: () {},
          ),
        ),
      ],
    );
  }

  SettingSection pushNotificationSection() {
    return SettingSection(
      headerText: "Notifications".toUpperCase(),
      headerFontSize: 15.0,
      headerTextColor: Colors.black87,
      backgroundColor: Colors.white,
      disableDivider: false,
      children: <Widget>[
        Container(
          child: SwitchRow(
            label: "Push Notification",
            disableDivider: false,
            value: isPushNotification,
            onSwitchChange: (switchStatus) {
              setState(() {
                switchStatus
                    ? isPushNotification = true
                    : isPushNotification = false;
              });
            },
            onTap: () {},
          ),
        ),
        Container(
          child: SwitchRow(
            label: "Local Notification",
            disableDivider: false,
            value: isLocalNotification,
            onSwitchChange: (switchStatus) {
              setState(() {
                switchStatus
                    ? isLocalNotification = true
                    : isLocalNotification = false;
              });
            },
            onTap: () {},
          ),
        )
      ],
    );
  }
}
