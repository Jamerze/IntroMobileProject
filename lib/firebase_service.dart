import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startup_namer/Classes/Student.dart';
import 'package:startup_namer/Classes/exam.dart';
import 'package:startup_namer/teacher.dart';

class FirebaseService {
  // ignore: deprecated_member_use
  static final databaseReference = FirebaseDatabase.instance.reference();

  //Teacher
  static Future<bool> authorizeTeacher(
      String lectorEmail, String password) async {
    int i = 0;
    await databaseReference
        .child('lectors')
        .get()
        .asStream()
        .forEach((element) {
      element.children.forEach((a) {
        print(a.key);
        if (a.child('email').value == lectorEmail &&
            a.child('pass').value == password) {
          Teacher.setCurrentTeacher(Teacher(a.key));
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

  static Future<bool> updateTeacher(
      String lectorEmail, String nieuwWachtwoord) async {
    try {
      String lectorKey = await receiveTeacherKey(lectorEmail);

      await databaseReference
          .child('lectors/$lectorKey')
          .child('pass')
          .set(nieuwWachtwoord);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<String> receiveTeacherKey(String lectorEmail) async {
    String lectorKey = "";
    await databaseReference
        .child('lectors')
        .get()
        .asStream()
        .forEach((element) {
      element.children.forEach((a) {
        if (a.child('email').value == lectorEmail) {
          lectorKey = a.key.toString();
        }
      });
    });
    return lectorKey;
  }


  //Student
  static Future<bool> authorizeStudent(String sNumber) async {
    int i = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await databaseReference
        .child('students')
        .get()
        .asStream()
        .forEach((element) {
      element.children.forEach((a) {
        if (a.child('sId').value == sNumber) {
          Student.setCurrentStudent(Student(
              a.child('sId').value.toString(),
              a.child('name').value.toString(),
              a.child('points').value.toString()));
          i++;
        }
      });
    });

    if (i == 1) {
      prefs.setString("sID", Student.getCurrentStudent().studentNumber);
      prefs.setString("points", Student.getCurrentStudent().points);
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> addStudent(
      String studentenNr, String studentenNaam) async {
    int i = 0;
    await databaseReference
        .child('students')
        .child("student" + studentenNr.substring(1, studentenNr.length))
        .set({"sId": studentenNr, "name": studentenNaam, "points": 0});
    await getStudents();
    return true;
  }

  static Future<bool> deleteStudent() async {
    try {
      await databaseReference.child('studenten').remove();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateStudentPoints(String sId, String points) async {
    try {
      await databaseReference
          .child('students')
          .child("student" + sId.substring(1, sId.length))
          .child("points")
          .set(points);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<List<Student>> getStudents() async {
    // ignore: deprecated_member_use
    List<Student> studentList = [];
    await databaseReference.child('students').get().asStream().forEach((s) {
      s.children.forEach((element) {
        studentList.add(Student(
            element.child('sId').value.toString(),
            element.child('name').value.toString(),
            element.child('points').value.toString()));
      });
    });
    return studentList;
  }


  //Exam
  static void saveExamAnswers(String sId, List<dynamic> answers) {
    final path = databaseReference.child('/examAnswers').child("/$sId");
    int i = 1;
    Exam.answers.forEach((answer) {
      path.child("answer$i").set({'answer$i': answer});
      i++;
    });
    databaseReference
        .child('students')
        .child("student" + sId.substring(1, sId.length))
        .child("points")
        .set(0);
  }

  static Future<bool> addExamQuestion(String antwoorden,
      String correctAntwoord, String vraag, String vraagType) async {
    int i = await getLastQuestionIdPlus1();
    try {
      await databaseReference.child('vragen').child('Vraag$i').set({
        "Antwoorden": antwoorden,
        "Correct_antwoord": correctAntwoord,
        "Vraag": vraag,
        "VraagType": vraagType,
        "Vraag_id": i
      });

      print('$vraagType vraag toegevoegd');
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteExam() async {
    try {
      await databaseReference.child('vragen').remove();
      await databaseReference.child('examAnswers').remove();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<int> getLastQuestionIdPlus1() async {
    DataSnapshot laatsteVraag =
        await databaseReference.child('vragen').get().asStream().last;
    if (laatsteVraag.children.length == 0) {
      return 1;
    }
    return int.parse(
            laatsteVraag.children.last.child('Vraag_id').value.toString()) +
        1;
  }
}
