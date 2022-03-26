

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:itsmyday/logo/itsmyday_logo.dart';
import 'package:itsmyday/predictioncard/pred_card.dart';
import 'package:itsmyday/util/misc_utilities.dart';
import 'package:itsmyday/util/loader.dart';
import 'package:firebase_database/firebase_database.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, this.zodiacSign, this.currentUserName}) : super(key: key);

  final String title;
  String zodiacSign;
  String currentUserName;

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var _gotPredictionFromDB = false;
  String _luckPrediction;
  int _luckRating;
  var _listOfPredictionFactors = List<Widget>();



  void showSnackbar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {

    getPredictionFromDB();

    if(_gotPredictionFromDB) {
      return Scaffold(
          appBar: AppBar(
            title: ItsMyDayLogo(logoSize: 28,location: "Home",),
          ),
          backgroundColor: Colors.white,
          key: _scaffoldKey,
          resizeToAvoidBottomPadding: false,
          body: Padding(padding: const EdgeInsets.all(8),
            child: Padding(
                padding: EdgeInsets.all(16),
                child: ListView(
//                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10.0),
                      width: 600,

                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            side: new BorderSide(color: Colors.deepPurple, width: 2.0),
                            borderRadius: BorderRadius.circular(4.0)),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                             ListTile(
                              title: Text('Welcome ' + widget.currentUserName + "!"),
                              subtitle: Text(widget.zodiacSign, style: TextStyle(color: Colors.amber),),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                TextButton(
                                  child: Text(getTodaysDate(), style: TextStyle(color: Colors.amber),),
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ],
                        ),
                      )
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: Text("Today's report for " + widget.zodiacSign.toUpperCase() + " is "),
                    ),
                    Column(
                      children: _listOfPredictionFactors,
                    )
                  ]
                )
            ),
          )
      );

    } else {
      return LoaderWithCustomWidget("Give me a moment...");
    }

  }

  void getPredictionFromDB() {
    final databaseReference = FirebaseDatabase.instance.reference();
    String date = getTodaysDate();
    databaseReference.child("predictions").child(date).child(widget.zodiacSign.toLowerCase()).once().then((DataSnapshot snapshot) {
      setState(() {
        _listOfPredictionFactors.clear();
        _gotPredictionFromDB = true;
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key, value) {
          String typeOfPrediction = value["typeOfPrediction"];
          String rating = value["rating"];
          String prediction_Text = value["prediction"];
          _listOfPredictionFactors.add(PredictionCard(typeOfPrediction: typeOfPrediction, rating: rating, prediction: prediction_Text,));
        });

      });
    });

  }


}