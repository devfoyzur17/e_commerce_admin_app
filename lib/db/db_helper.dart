import 'package:cloud_firestore/cloud_firestore.dart';

class DBHelper{

  static String adminCollection = "Admins";

  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<bool> isAdmin(String uid) async{
    final snapshot = await _db.collection(adminCollection).doc(uid).get();
    return snapshot.exists;
  }


}