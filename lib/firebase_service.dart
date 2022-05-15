import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:startup_namer/Classes/Student.dart';
import 'package:startup_namer/Classes/exam.dart';
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
          Lector.setCurrentLector(Lector(a.key));
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

  static Future<bool> authorizeStudent(String sNumber) async {
    int i = 0;
    await databaseReference
        .child('students')
        .get()
        .asStream()
        .forEach((element) {
      element.children.forEach((a) {
        if (a.child('sId').value == sNumber) {
          Student.setCurrentStudent(Student(a.child('sId').value.toString(),
              a.child('name').value.toString()));
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

  static Future<List<Student>> getStudents() async {
    // ignore: deprecated_member_use
    List<Student> studentList = [];
    await databaseReference.child('students').get().asStream().forEach((s) {
      s.children.forEach((element) {
        studentList.add(Student(element.child('sId').value.toString(),
            element.child('name').value.toString()));
        print('added student');
      });
    });
    return studentList;
  }

  static void saveExamAnswers(String sId, List<dynamic> answers) {
    final path = databaseReference.child('/examAnswers').child("/$sId");
    path.set({'answers': Exam.currentExam.answers}).then(
        (_) => print("sent to database"));
  }
}
