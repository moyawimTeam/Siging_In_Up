import 'package:flutter/material.dart';

class Box {
  static Future<dynamic> getShowDialog(
    BuildContext context,
    TextEditingController _controller,
    Function setSMS,
    Function signInWithSMS,
  ) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("ادخل الرقم "),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _controller,
                  keyboardType: TextInputType.phone,
                  onChanged: setSMS,
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("تأكيد"),
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: signInWithSMS,
              )
            ],
          );
        });
  }
}

// Alaa's popUpDialog

//  Future<String> popUpDialog(BuildContext context, String post) {
//    TextEditingController _controller = TextEditingController();
//    return showDialog(
//        context: context,
//        // ignore: missing_return
//        builder: (context) {
//          return AlertDialog(
//            shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.circular(10.0)),
//            backgroundColor: Colors.grey.shade100,
//            title: Text(
//              post,
//              textAlign: TextAlign.center,
//            ),
//            content: Directionality(
//              textDirection: TextDirection.rtl,
//              child: TextFormField(
//                controller: _controller,
//                autofocus: true,
//                style: TextStyle(fontSize: 19.0),
//                keyboardType: (post == "الخبرة")
//                    ? TextInputType.number
//                    : TextInputType.text,
//                decoration: InputDecoration(
//                    errorStyle: TextStyle(color: Colors.red.shade500),
//                    hintText: " ادخل $post",
//                    labelText: " فلتر حسب $post"),
//              ),
//            ),
//            actions: <Widget>[
//              MaterialButton(
//                textColor: Colors.white,
//                child: Text("إلغاء"),
//                onPressed: () => Navigator.of(context).pop(),
//                elevation: 5.0,
//                color: Colors.blue.shade400,
//              ),
//              MaterialButton(
//                textColor: Colors.white,
//                child: Text("فلتر"),
//                onPressed: () =>
//                    Navigator.of(context).pop(_controller.text.toString()),
//                elevation: 5.0,
//                color: Colors.blue.shade400,
//              ),
//            ],
//          );
//        });
//  }
