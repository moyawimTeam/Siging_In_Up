import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseOperations {
  final String uid;
  DatabaseOperations({this.uid});

  Future updateEmployeeData(String firstname, String lastname, String job,
      String city, String phonenb, String description) async {
    final CollectionReference jobCollection =
        Firestore.instance.collection('Employees');
    final CollectionReference phoneNumber =
        Firestore.instance.collection('PhoneNumbers');
    await jobCollection.document(uid).setData({
      'name': firstname,
      'lastname': lastname,
      'phone number': phonenb,
      'description': description,
      'job': job,
      'city': city,
    });
    await phoneNumber.document(phonenb).setData({});
  }

  Future updateEmployerData(
      String firstname, String lastname, String phonenb) async {
    final CollectionReference jobCollection =
        Firestore.instance.collection('Employers');
    final CollectionReference phoneNumber =
        Firestore.instance.collection('PhoneNumbers');
    await jobCollection.document(uid).setData({
      'name': firstname,
      'lastname': lastname,
      'phone number': phonenb,
    });
    await phoneNumber.document(phonenb).setData({});
  }
}
