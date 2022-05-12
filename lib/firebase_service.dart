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
      print(element.children.last.child('email').value);
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

  static Future<List<Student>> studentenOntvangen() async {
    List<Student> studentenLijst = [];
    await databaseReference
        .child('students')
        .get()
        .asStream()
        .forEach((element) {
      element.children.forEach((a) {
        studentenLijst.add(new Student(a.child('sId').value.toString(), a.child('name').value.toString()));
      });
    });

    return studentenLijst;
  }

  static Future<bool> studentToevoegen(
      String studentenNr, String studentenNaam) async {
    int i = 0;
    await databaseReference
        .child('students')
        .child("student" + studentenNr.substring(1, studentenNr.length))
        .set({"sId": studentenNr, "name": studentenNaam});
    await studentenOntvangen();
    return true;
  }

  static Future<bool> studentenVerwijderen() async {
    try {
      await databaseReference.child('students').remove();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> examenvraagToevoegen(String antwoorden,
      String correctAntwoord, String vraag, String vraagType) async {
    int i = await laatsteVraagIdPlus1Terugkrijgen();
    try {
      await databaseReference.child('questions').child('question$i').set({
        "answers": antwoorden,
        "correct_answer": correctAntwoord,
        "question": vraag,
        "questionType": vraagType,
        "question_id": i
      });

      print('$vraagType vraag toegevoegd');
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> examenVerwijderen() async {
    try {
      await databaseReference.child('questions').remove();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<int> laatsteVraagIdPlus1Terugkrijgen() async {
    DataSnapshot laatsteVraag =
        await databaseReference.child('questions').get().asStream().last;
    if (laatsteVraag.children.length == 0) {
      return 1;
    }
    return int.parse(
            laatsteVraag.children.last.child('question_id').value.toString()) +
        1;
  }
}

class Student{
  final String studentenNr;
  final String studentenNaam;

  Student(this.studentenNr, this.studentenNaam);
}
