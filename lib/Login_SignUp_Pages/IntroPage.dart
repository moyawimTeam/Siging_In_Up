import 'package:flutter/material.dart';

import 'SignUp-Employee.dart';
import 'SignUp-employer.dart';

//void main(){
//  runApp(MyIntro());
//}
//
//
//class MyIntro extends StatelessWidget{
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: Intro(),
//    );
//  }
//}

Widget Intro() {
  return DefaultTabController(
    length: 2,
    child: Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: null),
        centerTitle: true,
        title: Text(
          'أنشئ حساب',
          style: TextStyle(fontSize: 26),
        ),
        bottom: TabBar(
          tabs: [
            Tab(
              child: Text(
                "مياوم",
                style: TextStyle(fontSize: 25),
              ),
            ),
            Tab(
                child: Text(
              "رب عمل",
              style: TextStyle(fontSize: 25),
            )),
          ],
        ),
      ),
      body: TabBarView(
        children: [SignUpEmployee(), SignUpEmployer()],
      ),
    ),
  );
}
