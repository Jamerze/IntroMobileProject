import 'package:flutter/material.dart';

import 'Classes/Student.dart';

class StudentSubmittedPage extends StatelessWidget {
  const StudentSubmittedPage({Key? key}) : super(key: key);

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
        Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
            "Het examen werd correct afgerond. Gelieve de app te verlaten.",
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Open Sans',
            ),
          ),
        ])
      ]),
    );
  }
}
