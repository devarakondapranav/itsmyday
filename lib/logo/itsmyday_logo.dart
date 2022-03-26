
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItsMyDayLogo extends StatelessWidget {

  double logoSize = 50;
  String logoText = "It's My Day";
  String location;

  ItsMyDayLogo({this.logoSize, this.location});


  @override
  Widget build(BuildContext context) {

    double imageHeight = logoSize;
    double imageWidth = logoSize;
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center;


    if(location == "Auth") {
      imageWidth = 50;
      imageHeight = 50;
      mainAxisAlignment = MainAxisAlignment.center;
    } else if (location == "Home") {
        imageWidth = 45;
        imageHeight = 45;
        mainAxisAlignment = MainAxisAlignment.start;
    }

    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: <Widget>[
          Container(child: Image.asset(
            'assets/itsmyday_logo.png',
            height: imageHeight,
            width: imageWidth,
          )),
          SizedBox(
            width: 10,
          ),
          Text(logoText, style: GoogleFonts.pacifico(
              color: Colors.white,
              fontSize: logoSize
          ))
        ],
      )
    );
  }
}