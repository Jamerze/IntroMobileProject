import 'package:flutter/material.dart';
import 'package:startup_namer/teacher_login.dart';
import 'package:startup_namer/student_login.dart';

class StartingPage extends StatelessWidget {
  StartingPage({Key? key}) : super(key: key);

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
        ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(15),
            ),
            SizedBox(
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
                      MaterialPageRoute(builder: (context) => StudentLogin()),
                    );
                  },
                  child: Text(
                    'Login als student',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Open Sans',
                    ),
                  ),
                )),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
            ),
            SizedBox(
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
                      MaterialPageRoute(builder: (context) => LectorLogin()),
                    );
                  },
                  child: Text(
                    'Login als lector',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Open Sans',
                    ),
                  ),
                )),
          ]),
        ));
  }
}
