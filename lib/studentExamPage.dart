import 'dart:html';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:startup_namer/firebase_service.dart';
import 'package:startup_namer/studentSubmittedPage.dart';
import 'Classes/Student.dart';
import 'Classes/exam.dart';

class studentExamPage extends StatelessWidget {
  studentExamPage({Key? key}) : super(key: key);

  final Exam exam = Exam();

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
              )
            ]),
        body: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(30),
                child: Container(
                  child: CountdownTimer(
                    endTime: exam.endTime,
                    onEnd: exam.submit,
                    controller: exam.controller,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                padding: EdgeInsets.all(15),
                child: SizedBox(
                    width: 200.0,
                    height: 50.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red[900],
                        onPrimary: Colors.white,
                      ),
                      onPressed: () {
                        FirebaseService.saveExamAnswers(
                            Student.getCurrentStudent().studentNumber,
                            Exam.currentExam.answers);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StudentSubmittedPage()),
                        );
                      },
                      child: Text(
                        'Indienen',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Open Sans',
                        ),
                      ),
                    )),
              ),
            ],
          ),
          ListView(shrinkWrap: true, children: <Widget>[
            Container(
                height: 75,
                child: Card(
                    child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MultipleChoiceExamPage()),
                          );
                        },
                        title: Text(
                          "Vraag 1",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Open Sans',
                          ),
                        ),
                        subtitle: Text(
                          "joww hoe gaat het?",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Open Sans',
                          ),
                        )))),
            Container(
                height: 75,
                child: Card(
                    child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OpenQuestionPage()),
                          );
                        },
                        title: Text(
                          "Vraag 2",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Open Sans',
                          ),
                        ),
                        subtitle: Text(
                          "hoe heet je?",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Open Sans',
                          ),
                        )))),
            Container(
                height: 75,
                child: Card(
                    child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CodeCheckPage()),
                          );
                        },
                        title: Text(
                          "Vraag 3",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Open Sans',
                          ),
                        ),
                        subtitle: Text(
                          "verbeter volgende code",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Open Sans',
                          ),
                        ))))
          ])
        ]));
  }
}

class MultipleChoiceExamPage extends StatelessWidget {
  MultipleChoiceExamPage({Key? key}) : super(key: key);
  int questionNumber = 0;
  final _answer = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
              )
            ]),
        body: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.all(15),
                child: SizedBox(
                    width: 200.0,
                    height: 50.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red[900],
                        onPrimary: Colors.white,
                      ),
                      onPressed: () {
                        //Exam.currentExam.answers[questionNumber] = _answer.text;
                        Navigator.pop(context);
                      },
                      child: Text(
                        'terug naar overzicht',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Open Sans',
                        ),
                      ),
                    )),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Vraag $questionNumber: ",
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'Open Sans',
                ),
              ),
              Text(
                "joww hoe gaat het?",
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Open Sans',
                ),
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "1. Goed \n2. Idk \n3. Slecht",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Open Sans',
                      ),
                    ),
                  ]),
            ],
          ),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 400,
                    padding: EdgeInsets.all(15),
                    child: TextFormField(
                      controller: _answer,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !value.contains("1") ||
                            !value.contains("2") ||
                            !value.contains("3") ||
                            !value.contains("4") ||
                            value.length.toInt() != 1) {
                          return 'gelieve een antwoord 1 - 4 op te geven';
                        }
                        return null;
                      },
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: "Jouw antwoord",
                        labelStyle: TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.red, width: 2.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ))
        ]));
  }
}

class OpenQuestionPage extends StatelessWidget {
  OpenQuestionPage({Key? key}) : super(key: key);
  int questionNumber = 0;
  final _answer = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
              )
            ]),
        body: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.all(15),
                child: SizedBox(
                    width: 200.0,
                    height: 50.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red[900],
                        onPrimary: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'terug naar overzicht',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Open Sans',
                        ),
                      ),
                    )),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Vraag $questionNumber: ",
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'Open Sans',
                ),
              ),
              Text(
                "hoe heet je?",
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Open Sans',
                ),
              ),
            ],
          ),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 400,
                    padding: EdgeInsets.all(15),
                    child: TextFormField(
                      controller: _answer,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'gelieve een antwoord op te geven';
                        }
                        return null;
                      },
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: "Jouw antwoord",
                        labelStyle: TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.red, width: 2.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ))
        ]));
  }
}

class CodeCheckPage extends StatelessWidget {
  CodeCheckPage({Key? key}) : super(key: key);
  int questionNumber = 0;
  final _answer = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
              )
            ]),
        body: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.all(15),
                child: SizedBox(
                    width: 200.0,
                    height: 50.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red[900],
                        onPrimary: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'terug naar overzicht',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Open Sans',
                        ),
                      ),
                    )),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Vraag $questionNumber: ",
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'Open Sans',
                ),
              ),
              Text(
                "Verbeter volgende code",
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Open Sans',
                ),
              ),
              Text(
                "console.print['lol']",
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Open Sans',
                ),
              ),
            ],
          ),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 1000,
                    padding: EdgeInsets.all(15),
                    child: TextFormField(
                      controller: _answer,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'gelieve een antwoord op te geven';
                        }
                        return null;
                      },
                      maxLines: 15,
                      minLines: 15,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: "Jouw antwoord",
                        labelStyle: TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.red, width: 2.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ))
        ]));
  }
}
