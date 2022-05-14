import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
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
      body: Container(
        child: CountdownTimer(
          endTime: exam.endTime,
          onEnd: exam.submit,
          controller: exam.controller,
        ),
      ),
    );
  }
}
