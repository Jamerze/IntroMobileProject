import 'package:flutter/material.dart';
import 'package:startup_namer/starting_page.dart';
import 'package:startup_namer/student_exam_page.dart';
import 'package:startup_namer/student_login.dart';
import 'Classes/Student.dart';
import 'firebase_service.dart';

class StudentLandingPage extends StatelessWidget {
  StudentLandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Examinator",
              style: TextStyle(
                  fontFamily: 'Open Sans', fontWeight: FontWeight.bold)),
          backgroundColor: Colors.red[900],
          centerTitle: true,
          leading: Image.asset("../assets/AP_logo_letters_mono.png"),
          leadingWidth: 70,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
            ),
            Text(
              Student.getCurrentStudent().name +
                  " | " +
                  Student.getCurrentStudent().studentNumber,
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Open Sans',
              ),
            ),
          ],
        ),
        body: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(15),
                    child: SizedBox(
                        width: 300.0,
                        height: 100.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red[900],
                            onPrimary: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StudentExamPage2()),
                            );
                          },
                          child: Text(
                            'Start het examen',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'Open Sans',
                            ),
                          ),
                        )),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(15),
                    child: SizedBox(
                        width: 300.0,
                        height: 100.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red[900],
                            onPrimary: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StudentLogin()),
                            );
                          },
                          child: Text(
                            'Ga terug',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'Open Sans',
                            ),
                          ),
                        )),
                  ),
                ])));
  }
}
