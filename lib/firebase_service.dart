import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:startup_namer/lector.dart';

class FirebaseService {
  // ignore: deprecated_member_use
  static final databaseReference = FirebaseDatabase.instance.reference();

  static Future<bool> authorizeLector(
      String lectorEmail, String password) async {
    int i = 0;
    await databaseReference
        .child('lectors')
        .get()
        .asStream()
        .forEach((element) {
      element.children.forEach((a) {
        if (a.child('email').value == lectorEmail &&
            a.child('pass').value == password) {
          i++;
        }
      });
    });
    if (i == 1) {
      return true;
    } else {
      return false;
    }
  }
}
