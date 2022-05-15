import 'package:flutter/material.dart';
import 'package:startup_namer/studentLandingPage.dart';
import 'Classes/Student.dart';
import 'firebase_service.dart';
import 'lector.dart';

class StudentLogin extends StatelessWidget {
  StudentLogin({Key? key}) : super(key: key);
  final _sNumber = TextEditingController();
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
        ),
        body: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'Log in als student',
                      style: TextStyle(
                          color: Colors.red[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(children: [
                      Container(
                        alignment: Alignment.center,
                        width: 400,
                        padding: EdgeInsets.all(15),
                        child: TextFormField(
                          controller: _sNumber,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !value.contains("s") ||
                                value.length.toInt() != 7) {
                              return 's-nummer begint met "s" en is 7 karakters lang';
                            }
                            return null;
                          },
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: "s-nummer",
                            labelStyle: TextStyle(color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2.5),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 75,
                              padding: EdgeInsets.all(15),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red[900],
                                  onPrimary: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Ga Terug',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: 'Open Sans',
                                  ),
                                ),
                              )),
                          Container(
                              height: 75,
                              padding: EdgeInsets.all(15),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red[900],
                                  onPrimary: Colors.white,
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    if (await FirebaseService.authorizeStudent(
                                        _sNumber.text)) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                StudentLandingPage()),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text('S-nummer is fout.')),
                                      );
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'S-nummer moet ingevuld worden.')),
                                    );
                                  }
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: 'Open Sans',
                                  ),
                                ),
                              ))
                        ],
                      )
                    ]),
                  )
                ])));
  }
}
    
    // Column(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     children: <Widget>[
    //       Container(
    //         alignment: Alignment.center,
    //         padding: EdgeInsets.all(15),
    //         child: Text(
    //           'Log in als Student',
    //           style: TextStyle(
    //               color: Colors.red[800],
    //               fontWeight: FontWeight.bold,
    //               fontSize: 25),
    //         ),
    //       ),
    //       ListView(shrinkWrap: true, children: <Widget>[
    //         Card(
    //             child: ListTile(
    //           title:
    //               Text(FirebaseService.getStudents().),
    //         ))
    //       ])
    //     ])));