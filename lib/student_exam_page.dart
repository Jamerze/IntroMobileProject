import 'dart:html';
import 'dart:js_util';
import 'dart:math';
import 'dart:ui';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:startup_namer/firebase_service.dart';
import 'package:startup_namer/student_submitted_page.dart';
import 'Classes/Student.dart';
import 'Classes/exam.dart';

class StudentExamPage2 extends StatefulWidget {
  const StudentExamPage2({Key? key}) : super(key: key);

  @override
  StudentExamPage2State createState() => StudentExamPage2State();
}

class StudentExamPage2State extends State<StudentExamPage2> {
  final fb = FirebaseDatabase.instance;
  var endData;
  var beginData;
  var keyData;

  @override
  Widget build(BuildContext context) {
    final ref = fb.ref().child('vragen');
    final Exam exam = Exam();

    var questionTypes = [];
    ref.get().asStream().forEach((element) {
      element.children.forEach((a) {
        questionTypes.add(a.child('VraagType').value);
        Exam.questions.add(a.child('Vraag').value);
        Exam.posAnswers.add(a.child('Antwoorden').value);
        Exam.answers.add("");
      });
    });
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
                            Exam.answers);
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
          Center(
            child: FirebaseAnimatedList(
              query: ref,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, snapshot, animation, index) {
                var snapshotValue = snapshot.value.toString();

                beginData = snapshotValue.replaceAll(
                    RegExp("{|}|subtitle: |title: "), "");
                beginData.trim();

                endData = beginData.split(',');

                return GestureDetector(
                    onTap: () {
                      setState(() {
                        keyData = snapshot.key;
                      });
                    },
                    child: Container(
                      height: 75,
                      child: Card(
                          child: ListTile(
                        title: Text(
                          "${index + 1}.${endData[2].toString().split(':')[1]}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Open Sans',
                          ),
                        ),
                        subtitle: Text(
                          endData[3].toString().split(':')[1],
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Open Sans',
                          ),
                        ),
                        onTap: () {
                          Exam.currentQuestion = index;
                          var option = questionTypes[index];
                          if (option == "meerkeuze") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MultipleChoiceExamPage()));
                          }
                          if (option == "open") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OpenQuestionPage()));
                          }
                          if (option == "codecheck") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CodeCheckPage()));
                          }
                        },
                      )),
                    ));
              },
            ),
          ),
        ]));
  }
}

class MultipleChoiceExamPage extends StatelessWidget {
  MultipleChoiceExamPage({Key? key}) : super(key: key);
  int questionNumber = Exam.currentQuestion;
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
                        Exam.answers[Exam.currentQuestion] = _answer.text;
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
                "Vraag ${Exam.currentQuestion + 1}:",
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'Open Sans',
                ),
              ),
              Text(
                "${Exam.questions[Exam.currentQuestion]}",
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Open Sans',
                ),
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "1. ${Exam.posAnswers[Exam.currentQuestion].toString().split(';')[0]} \n2. ${Exam.posAnswers[Exam.currentQuestion].toString().split(';')[1]} \n3. ${Exam.posAnswers[Exam.currentQuestion].toString().split(';')[2]} \n4. ${Exam.posAnswers[Exam.currentQuestion].toString().split(';')[3]} ",
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
                        Exam.answers[Exam.currentQuestion] = _answer.text;
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
                "Vraag ${Exam.currentQuestion + 1}: ",
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'Open Sans',
                ),
              ),
              Text(
                "${Exam.questions[Exam.currentQuestion]}",
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
                        Exam.answers[Exam.currentQuestion] = _answer.text;
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
                "Vraag ${Exam.currentQuestion + 1}:",
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'Open Sans',
                ),
              ),
              Text(
                "${Exam.questions[Exam.currentQuestion]} \n",
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Open Sans',
                ),
              ),
              Text(
                Exam.posAnswers[Exam.currentQuestion],
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
