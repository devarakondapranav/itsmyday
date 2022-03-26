

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itsmyday/after_auth/collect_name.dart';
import 'package:itsmyday/logo/itsmyday_logo.dart';
import 'package:itsmyday/util/misc_utilities.dart';

class OTPPage extends StatefulWidget {
  OTPPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _OTPPageState createState() => _OTPPageState();

}

class _OTPPageState extends State<OTPPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();
  String _verificationId;


  void showSnackbar(String message) {
    print(message);
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));

  }

  void verifyPhoneNumber() async {


    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      await _auth.signInWithCredential(phoneAuthCredential);
//      showSnackbar("Phone number automatically verified and user signed in: ${_auth.currentUser.uid}");
      showAlertDialog(context, "Verification Successful", "Phone number automatically verified. We need more info to proceed");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CollectName(title: "Name and DOB",)),
      );

    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
//      showSnackbar('Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
      showAlertDialog(context,"Verification",  "Phone number verification failed. Please try again");
    };
    PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
//      showSnackbar('Please check your phone for the verification code.');
      _verificationId = verificationId;
      showAlertDialog(context, "Verification",  "OTP sent to your phone. Please wait for automatic OTP verification");
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
//      showSnackbar("verification code: " + verificationId);
          showAlertDialog(context,"Verification",  "Verification code: " + _verificationId);
      _verificationId = verificationId;
    };

    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: _phoneNumberController.text,
          timeout: const Duration(seconds: 45),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      showSnackbar("Failed to Verify Phone Number: ${e}");
    }


  }

  void signInWithPhoneNumber() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _smsController.text,
      );

      final User user = (await _auth.signInWithCredential(credential)).user;

      showSnackbar("Successfully signed in UID: ${user.uid}");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CollectName(title: "Name and DOB",)),
      );

    } catch (e) {
      showSnackbar("Failed to sign in: " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        appBar: AppBar(
//          title: Text(widget.title),
//        ),
        key: _scaffoldKey,

        backgroundColor: Colors.deepPurple,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Center(
                child: Padding(padding: const EdgeInsets.all(8),
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 150,
                          ),
                          Center(
                            child: ItsMyDayLogo(logoSize: 48,location: "Auth",),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          TextFormField(
                            controller: _phoneNumberController,
                            decoration: InputDecoration(
                                labelText: 'Phone number (+xx xxx-xxx-xxxx)',
                                fillColor: Colors.white,
                                filled: true
                            ),

                          ),

                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            alignment: Alignment.center,
                            child: RaisedButton(
                              color: Colors.amberAccent,
                              child: Text("Get OTP"),
                              onPressed: () async {
                                verifyPhoneNumber();
                              },
                            ),
                          ),
                          TextFormField(
                            controller: _smsController,
                            decoration: InputDecoration(
                                labelText: 'Verification code',
                                fillColor: Colors.white,
                                filled: true
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 16.0),
                            alignment: Alignment.center,
                            child: RaisedButton(
                                color: Colors.amberAccent,
                                onPressed: () async {
                                  signInWithPhoneNumber();
                                },
                                child: Text("Sign in")),
                          ),

                        ],
                      )
                  ),
                )
                ,
              )
            ],
          ),
        )     );
  }
}