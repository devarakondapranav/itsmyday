import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_grid_pulse_indicator.dart';
import 'package:loading/loading.dart';

class LoaderWithCustomWidget extends StatelessWidget {

  String message;

  LoaderWithCustomWidget(this.message);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text(""),
    ),
    resizeToAvoidBottomPadding: false,
    body: Center(
        child: Loading(indicator: BallGridPulseIndicator(), size: 35.0,color: Colors.deepPurple)

      )
    );

  }

}