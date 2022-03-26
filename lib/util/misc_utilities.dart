import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String getZodiacSign({int month, int day}) {
  String zodiacSign;
  // checks month and date within the
  // valid range of a specified zodiac
  if (month == 12){

    if (day < 22)
      zodiacSign = "Sagittarius";
    else
      zodiacSign ="capricorn";
  }

  else if (month == 1){
    if (day < 20)
      zodiacSign = "Capricorn";
    else
      zodiacSign = "aquarius";
  }

  else if (month == 2){
    if (day < 19)
      zodiacSign = "Aquarius";
    else
      zodiacSign = "pisces";
  }

  else if(month == 3){
    if (day < 21)
      zodiacSign = "Pisces";
    else
      zodiacSign = "aries";
  }
  else if (month == 4){
    if (day < 20)
      zodiacSign = "Aries";
    else
      zodiacSign = "taurus";
  }

  else if (month == 5){
    if (day < 21)
      zodiacSign = "Taurus";
    else
      zodiacSign = "gemini";
  }

  else if( month == 6){
    if (day < 21)
      zodiacSign = "Gemini";
    else
      zodiacSign = "cancer";
  }

  else if (month == 7){
    if (day < 23)
      zodiacSign = "Cancer";
    else
      zodiacSign = "leo";
  }

  else if( month == 8){
    if (day < 23)
      zodiacSign = "Leo";
    else
      zodiacSign = "virgo";
  }

  else if (month == 9){
    if (day < 23)
      zodiacSign = "Virgo";
    else
      zodiacSign = "libra";
  }

  else if (month == 10){
    if (day < 23)
      zodiacSign = "Libra";
    else
      zodiacSign = "scorpio";
  }

  else if (month == 11){
    if (day < 22)
      zodiacSign = "scorpio";
    else
      zodiacSign = "sagittarius";
  }
  return zodiacSign.toLowerCase();
}

String getTodaysDate() {
 DateTime now = DateTime.now();
 return now.year.toString() + "-" + now.month.toString() + "-" + now.day.toString();
}

showAlertDialog(BuildContext context,String title,  String message) {



  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}