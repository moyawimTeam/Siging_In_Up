import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AlertPage extends StatelessWidget {
  final phonenb;
  const AlertPage({
    this.phonenb,
  });
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
          Firestore.instance.collection('PhoneNumbers').document().snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print("I am here");
          return AlertDialog(
            title: Text('already registered'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        } else {
          return null;
        }
      },
    );
  }
}
