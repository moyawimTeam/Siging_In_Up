import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moyawim2/Authentication_services/authservice.dart';
import 'package:moyawim2/Constants_Data/Data.dart';
import 'package:moyawim2/Constants_Data/constants.dart';
import 'package:moyawim2/Login_SignUp_Pages/Login_Page.dart';
import 'package:moyawim2/Login_SignUp_Pages/PopUp.dart';
import 'package:moyawim2/Temporary_Pages/test.dart';

import 'UI.dart';

class SignUpEmployee extends StatefulWidget {
  @override
  SignUpEmployeeState createState() {
    return SignUpEmployeeState();
  }
}

class dataVar {
  static String currentcity = 'غير محدد';
  static String currentJob = 'غير محدد';
  static String error = '';

  static String firstname = '';
  static String lastname = '';
  static String phonenumber = '';
  static String description = '';
}

// Create a corresponding State class.
// This class holds data related to the form.
class SignUpEmployeeState extends State<SignUpEmployee> {
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final myController = TextEditingController();
  final myControllerlast = TextEditingController();
  final customeFontSize = 20.0;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  FocusNode myFocusNode = new FocusNode();
  //for authentication
  bool codeSent = false;
  String verificationId, smsCode;

  void setVerId(String verId) {
    verificationId = verId;
  }

  void setCodeSent() {
    setState(() {
      codeSent = true;
    });
  }

  void setSMS(val) {
    smsCode = val;
  }

  void signInWithSMS() async {
    Navigator.pop(context);
    final code = _controller.text.trim();
    AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: code);
    AuthResult result = await AuthService().createEmployee(
        dataVar.firstname,
        dataVar.lastname,
        dataVar.phonenumber,
        dataVar.currentJob,
        dataVar.currentcity,
        dataVar.description,
        credential);
    FirebaseUser user = result.user;
    Navigator.pop(context);
    if (user != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Test()));
    } else {
      print("Error");
    }
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return getPage();
  }

  Widget getPage() {
    return Scaffold(
        body: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            HomePage(),
            Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                              "assets/Logo-Moyawem.jpeg",
                            ))),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      width: 300,
                      child: ListView(children: <Widget>[
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Card(
                              elevation: 7,
                              child: TextFormField(
                                controller: myController,
                                textInputAction: TextInputAction.done,
                                style: TextStyle(fontSize: customeFontSize),
                                decoration: textInputDecoration.copyWith(
                                    hintText: "ادخل الإسم الأول",
                                    labelText: " الإسم الأول",
                                    labelStyle: TextStyle(
                                        color: myFocusNode.hasFocus
                                            ? Colors.red
                                            : Colors.black)),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'الرجاء إدخال الإسم الأول';
                                  }
                                  return null;
                                },
                                onChanged: (String val) {
                                  setState(() {
                                    dataVar.firstname = val;
                                  });
                                },
                              ),
                            )),
                        Card(
                          elevation: 7,
                          child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                controller: myControllerlast,
                                textInputAction: TextInputAction.done,
                                style: TextStyle(fontSize: customeFontSize),
                                decoration: textInputDecoration.copyWith(
                                    hintText: "ادخل إسم العائلة",
                                    labelText: " إسم العائلة",
                                    labelStyle: TextStyle(
                                        color: myFocusNode.hasFocus
                                            ? Colors.red
                                            : Colors.black)),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'الرجاء إدخال إسم العائلة';
                                  }
                                  return null;
                                },
                                onChanged: (String val) {
                                  setState(() {
                                    dataVar.lastname = val;
                                  });
                                },
                              )),
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Card(
                              elevation: 6.0,
                              child: TextFormField(
                                textInputAction: TextInputAction.done,
                                style: TextStyle(fontSize: customeFontSize),
                                keyboardType: TextInputType.phone,
                                textAlign: TextAlign.right,
                                decoration: textInputDecoration.copyWith(
                                    hintText: "ادخل رقم الهاتف",
                                    labelText: "رقم الهاتف",
                                    labelStyle: TextStyle(
                                        color: myFocusNode.hasFocus
                                            ? Colors.red
                                            : Colors.black)),
                                validator: (value) {
                                  if (value.length != 8) {
                                    return 'الرجاء إدخال رقم الهاتف(8 أرقام)';
                                  }
                                  return null;
                                },
                                onChanged: (String val) {
                                  setState(() {
                                    dataVar.phonenumber = "+961" + val;
                                  });
                                },
                              ),
                            )),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Card(
                              elevation: 5.0,
                              child: TextFormField(
                                textInputAction: TextInputAction.done,
                                style: TextStyle(fontSize: customeFontSize),
                                decoration: textInputDecoration.copyWith(
                                    hintText: "أدخل معلومات إضافية",
                                    labelText: " الحالة",
                                    labelStyle: TextStyle(
                                        color: myFocusNode.hasFocus
                                            ? Colors.red
                                            : Colors.black)),
                                onChanged: (String val) {
                                  setState(() {
                                    dataVar.lastname = val;
                                  });
                                },
                              ),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Text(
                                      "اختر وظيفة",
                                      style: TextStyle(
                                          fontSize: customeFontSize - 1),
                                    )),
                                Container(
                                  child: DropdownButton(
                                      items: jobsList.map((var dropItems) {
                                        return DropdownMenuItem(
                                            value: dropItems,
                                            child: Text(dropItems));
                                      }).toList(),
                                      onChanged: (var Item) {
                                        setState(() {
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          dataVar.currentJob = Item;
                                        });
                                      },
                                      value: dataVar.currentJob),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Text(
                                      "اختر منطقة",
                                      style: TextStyle(
                                          fontSize: customeFontSize - 1),
                                    )),
                                Container(
                                  child: DropdownButton(
                                      items: cities.map((var dropItems) {
                                        return DropdownMenuItem(
                                            value: dropItems,
                                            child: Text(dropItems));
                                      }).toList(),
                                      onChanged: (var Item) {
                                        setState(() {
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          dataVar.currentcity = Item;
                                        });
                                      },
                                      value: dataVar.currentcity),
                                )
                              ],
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            width: 150,
                            child: RaisedButton(
                              color: Colors.blueAccent,
                              onPressed: () async {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                if (dataVar.currentJob == 'غير محدد') {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                            'الرجاء اختيار الوظيفة',
                                            textAlign: TextAlign.right,
                                          ),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text('حسنا'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        );
                                      });
                                } else if (dataVar.currentcity == 'غير محدد') {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                            'الرجاء اختيار المنطقة',
                                            textAlign: TextAlign.right,
                                          ),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text('حسنا'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        );
                                      });
                                } else if (_formKey.currentState.validate()) {
                                  _controller.clear();
                                  bool alreadyRegistered = await AuthService()
                                      .checkNb(dataVar.phonenumber);
                                  if (alreadyRegistered) {
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text(
                                              'هنالك حساب بهذا الرقم الرجاء تسجيل الدخول',
                                              textAlign: TextAlign.right,
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text('حسنا'),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              )
                                            ],
                                          );
                                        });
                                  } else {
                                    codeSent
                                        ? await AuthService().signInWithOTP(
                                            smsCode, verificationId)
                                        : await AuthService().verifyPhone(
                                            context,
                                            'signupEmpl',
                                            dataVar.phonenumber,
                                            setVerId,
                                            setCodeSent,
                                            dataVar.firstname,
                                            dataVar.lastname,
                                            dataVar.phonenumber,
                                            dataVar.currentJob,
                                            dataVar.currentcity,
                                            dataVar.description,
                                          );

                                    if (!codeSent) {
                                      await Box.getShowDialog(context,
                                          _controller, setSMS, signInWithSMS);
                                    }
                                  }
                                }
                              },
                              child: Text(
                                "إنشاء حساب",
                                style: TextStyle(
                                    fontSize: customeFontSize,
                                    color: Colors.white),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                side: BorderSide(color: Colors.blueAccent),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return LoginPage();
                                }));
                              },
                              child: RichText(
                                softWrap: true,
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: "لديك حساب؟ ",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15.0),
                                    children: [
                                      TextSpan(
                                          text: "سجل الدخول",
                                          style: TextStyle(color: Colors.red))
                                    ]),
                                textDirection: TextDirection.rtl,
                              )),
                        )
                      ]),
                    ),
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    ));
  }
}
