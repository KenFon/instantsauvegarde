import 'package:flutter/material.dart';
import 'package:beauty_textfield/beauty_textfield.dart';
import 'package:flutter/widgets.dart';

class SearchEvent extends StatelessWidget {
  //final Function searchEventFc;
  final idController = TextEditingController();



  void submitData() {
    final eventId = idController.text;

    if (eventId.isEmpty) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child :
        Card(
          margin: EdgeInsets.all(30),
          elevation: 2,
          child:
            Container(
              child :
                Column(
                  children: <Widget>[
                    BeautyTextfield(
                      width: double.maxFinite,
                      height: 60,
                      margin: EdgeInsets.all(0),
                      cornerRadius: BorderRadius.all(Radius.circular(10)),
                      accentColor: Colors.white70,
                      textColor: Colors.black87,
                      backgroundColor: Colors.white70,
                      duration: Duration(milliseconds: 300),
                      inputType: TextInputType.text,
                      wordSpacing: 0.5,
                      prefixIcon: Icon(Icons.favorite, color: Colors.black87),
                      placeholder: "Entrez l'id de l'événement",
                      fontWeight: FontWeight.w500,
                      onTap: () {
                        print('Click');
                      },
                      onChanged: (text) {
                        print(text);
                      },
                      onSubmitted: (data) {
                        print(data.length);
                      },
                    )
                  ],
                )
            ),
      )
    );
  }
}