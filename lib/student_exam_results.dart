import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startup_namer/Classes/student.dart';
import 'package:startup_namer/firebase_service.dart';
import 'package:startup_namer/teacher.dart';

class StudentExamResults extends StatefulWidget {
  const StudentExamResults({Key? key}) : super(key: key);

  @override
  StudentExamResultsState createState() => StudentExamResultsState();
}

class StudentExamResultsState extends State<StudentExamResults> {
  final _formKey = GlobalKey<FormState>();
  final fb = FirebaseDatabase.instance;
  var points = TextEditingController();

  //Answer Data
  var endData;
  var beginData;
  var keyData;

  //Question Data
  var endData2;
  var beginData2;
  var keyData2;

  var studentNr = "";

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      points.text = prefs.getString("points").toString();
      studentNr = prefs.getString("sID").toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    var ref;
    if (studentNr != "") {
      final ref2 = fb.ref().child('vragen');
      final ref = fb.ref().child('examAnswers').child(studentNr);
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
                  Teacher.getCurrentTeacher().name,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Open Sans',
                  ),
                ),
              ]),
          body: Column(
            children: [
              Container(
                  child: Column(
                children: [
                  Padding(
                    child: Text("Examenvragen:",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    padding: EdgeInsets.all(16.0),
                  ),
                  Center(
                    child: FirebaseAnimatedList(
                      query: ref2,
                      shrinkWrap: true,
                      itemBuilder: (context, snapshot, animation, index) {
                        var snapshotValue = snapshot.value.toString();
                        print(snapshotValue);
                        beginData2 = snapshotValue.replaceAll(
                            RegExp("{|}|subtitle: |title: "), "");
                        beginData2.trim();

                        endData2 = beginData2.split(',');
                        print(endData2);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              keyData2 = snapshot.key;
                            });
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 40, right: 40, top: 5, bottom: 5),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                tileColor: Colors.red[900],
                                title: new Center(
                                  child: Text(
                                    endData2[2],
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                subtitle: new Center(
                                  child: Text(
                                    endData2[0],
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )),
              Container(
                  child: Column(
                children: [
                  Padding(
                    child: Text("Antwoorden ($studentNr)",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    padding: EdgeInsets.all(16.0),
                  ),
                  Center(
                    child: FirebaseAnimatedList(
                      query: ref,
                      shrinkWrap: true,
                      itemBuilder: (context, snapshot, animation, index) {
                        var snapshotValue = snapshot.value.toString();
                        print(snapshotValue);
                        beginData = snapshotValue.replaceAll(
                            RegExp("{|}|subtitle: |title: "), "");
                        beginData.trim();

                        endData = beginData.split(',');
                        print(endData);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              keyData = snapshot.key;
                            });
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 40, right: 40, top: 5, bottom: 5),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                tileColor: Colors.red[900],
                                title: new Center(
                                  child: Text(
                                    endData[0],
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )),
              Container(
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 400,
                            padding: EdgeInsets.all(15),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    int.parse(value) == null ||
                                    (int.parse(value) != null &&
                                            int.parse(value) > 20 ||
                                        int.parse(value) < 0)) {
                                  return 'Een cijfer tussen 0 en 20 dient ingevuld te worden.';
                                }
                                return null;
                              },
                              controller: points,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: "Punten",
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
                                        // If the form is valid, display a snackbar. In the real world,
                                        // you'd often call a server or save the information in a database.
                                        if (await FirebaseService
                                            .updateStudentPoints(
                                                studentNr, points.text)) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'Punten werden toegekend aan de student.')),
                                          );
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const TeacherPage()),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'Punten konden niet toegekend worden.')),
                                          );
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Punten moeten correct ingevuld worden.')),
                                        );
                                      }
                                    },
                                    child: Text(
                                      'Opslaan',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: 'Open Sans',
                                      ),
                                    ),
                                  ))
                            ],
                          )
                        ],
                      )))
            ],
          ));
    } else {
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
                Teacher.getCurrentTeacher().name,
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Open Sans',
                ),
              ),
            ]),
      );
    }
  }
}
