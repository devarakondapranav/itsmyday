import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'after_auth/after_auth_user_verifier.dart';
import 'after_auth/collect_name.dart';
import 'after_auth/home_page.dart';
import 'otp/otp_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
    // signed in
      return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.deepPurple
        ),
        home: UserInfoVerifier(title: "It's my day"),
      );

    } else {
      return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: OTPPage(title: "It's my day"),
      );


    }

  }

  bool checkIfFirstTimeUser(User user) {
    return true;
  }
}

