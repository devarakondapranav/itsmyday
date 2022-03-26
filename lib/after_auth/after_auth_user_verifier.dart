

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:itsmyday/after_auth/collect_name.dart';
import 'package:itsmyday/util/loader.dart';

import 'home_page.dart';

class UserInfoVerifier extends StatefulWidget {
  UserInfoVerifier({Key key, this.title}) :  super(key: key);

  final String title;

  @override
  _UserInfoVerifierState createState() => _UserInfoVerifierState();

}

class _UserInfoVerifierState extends State<UserInfoVerifier> {

  bool _gotInfoFromDB = false;
  bool _isUserInfoAlreadyThere = false;

  String _existingUserZodiacSign;
  String _existingUserName;


  @override
  Widget build(BuildContext context) {
    checkUserInfo();
    if (_gotInfoFromDB) {
      if(_isUserInfoAlreadyThere) {
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
          ),
          home: HomePage(title: "It's my day", zodiacSign: _existingUserZodiacSign, currentUserName: _existingUserName,),
        );
      } else {
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
          ),
          home: CollectName(title: "We need your name and DOB"),
        );

      }
    } else {
      return LoaderWithCustomWidget("Give me a moment...");
    }
  }

  bool checkUserInfo() {
    User user = FirebaseAuth.instance.currentUser;
    final databaseReference = FirebaseDatabase.instance.reference();
    databaseReference.child("users").child(user.uid).once().then((DataSnapshot snapshot) {

      setState( () {
        _gotInfoFromDB = true;
        _isUserInfoAlreadyThere = snapshot.value != null;
        if(_isUserInfoAlreadyThere) {
          _existingUserZodiacSign = snapshot.value["zodiacSign"];
          _existingUserName = snapshot.value["name"];
        }

      });

    });
  }

}