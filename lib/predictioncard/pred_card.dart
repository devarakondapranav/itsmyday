import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itsmyday/predictioncard/slider.dart';

class PredictionCard extends StatelessWidget {
  String typeOfPrediction;
  String rating;
  String prediction;
  double _currentSliderValue;

  PredictionCard({this.typeOfPrediction, this.rating, this.prediction});

  @override
  Widget build(BuildContext context) {

    _currentSliderValue = double.parse(rating);

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.album),
            title: Text("$typeOfPrediction", style: TextStyle(color: Colors.deepPurple),),
            subtitle: Text('$prediction'),
          ),
          SizedBox(
            height: 20.0,
          ),
          SliderWidget( sliderHeight: 25,fullWidth: true, rating: double.parse(rating)),
          SizedBox(
            height: 20.0,
          )
        ],
      ),
    );
  }


}