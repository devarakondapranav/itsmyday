

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:itsmyday/after_auth/home_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:itsmyday/logo/itsmyday_logo.dart';
import 'package:itsmyday/util/misc_utilities.dart';


class CollectName extends StatefulWidget {

  CollectName({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CollectNameState createState() => _CollectNameState();

}

class _CollectNameState extends State<CollectName> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _DOBController = TextEditingController();
  DateTime selectedDate = DateTime.now();


  void showSnackbar(String message) {
    print(message);
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));

  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
      helpText: "Select date of birth"
//      initialDatePickerMode: DatePickerMode.year
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.amber;
      }
      return Colors.white;
    }


    return Scaffold(
        backgroundColor: Colors.deepPurple,
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: false,
        body: Padding(padding: const EdgeInsets.all(8),
          child: Center(
            child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    SizedBox(
                      height: 150,
                    ),
                    Center(
                      child: ItsMyDayLogo(logoSize: 48, location: "Auth",),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                          labelText: 'Enter your name',
                        filled: true,
                        fillColor: Colors.white
                      ),

                    ),
                    SizedBox(
                      height: 20.0,
                    ),

//                  TextFormField(
//                    controller: _DOBController,
//                    decoration: const InputDecoration(labelText: 'DOB'), // TODO convert this 3 dropdowns from dd, mm, yyyy
//                  ),
                    TextButton.icon(onPressed: () =>_selectDate(context),

                      label: Text("Select Date of birth"),
                      icon: Icon(Icons.calendar_today),
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.resolveWith(getColor,)
                      ),

                    ),
                    Text(
                      "${selectedDate.toLocal()}".split(' ')[0],
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.white),

                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 16.0),
                      alignment: Alignment.center,
                      child: RaisedButton(
                          color: Colors.amberAccent,
                          onPressed: () async {
                            saveNameAndDOB();
                          },
                          child: Text("Lets Go")),
                    ),

                  ],
                )
            ),
          ),
        )
    );
  }

  void saveNameAndDOB() {

    final databaseReference = FirebaseDatabase.instance.reference();
    User currentUser = FirebaseAuth.instance.currentUser;


    String zodiacSign = getZodiacSign(month: selectedDate.month, day: selectedDate.day); //TODO get the Date and month from the form

    databaseReference.child("users").child(currentUser.uid).set( {
      "name": _nameController.text,
      "zodiacSign": zodiacSign,
      "dayOfBirth": selectedDate.day,
      "monthOfBirth": selectedDate.month,
      "yearOfBirth": selectedDate.year
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage(title: "It's my day", zodiacSign: zodiacSign, currentUserName: _nameController.text )),
    );
  }
}