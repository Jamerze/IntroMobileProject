import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:startup_namer/add_codecheck_question.dart';
import 'package:startup_namer/firebase_service.dart';
import 'package:startup_namer/add_multiplechoice_question.dart';
import 'package:startup_namer/add_open_question.dart';
import 'package:startup_namer/search_student.dart';
import 'package:startup_namer/starting_page.dart';
import 'package:startup_namer/add_student.dart';

class Teacher {
  static Teacher _currentLector = Teacher("");
  String name = "";

  Teacher(n) {
    name = n;
  }

  static void setCurrentTeacher(lector) {
    _currentLector = lector;
  }

  static Teacher getCurrentTeacher() {
    return _currentLector;
  }
}

class TeacherPage extends StatefulWidget {
  const TeacherPage({Key? key}) : super(key: key);

  @override
  TeacherPageState createState() => TeacherPageState();
}

class TeacherPageState extends State<TeacherPage> {
  int pageIndex = 0;

  final pages = [
    ExamPage(),
    const StudentListPage(),
    settingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: pages[pageIndex],
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.red[900],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 0;
                });
              },
              icon: Icon(
                Icons.edit_note,
                color: Colors.white,
                size: 35,
              )),
          IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 1;
                });
              },
              icon: Icon(
                Icons.people,
                color: Colors.white,
                size: 35,
              )),
          IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 2;
                });
              },
              icon: Icon(
                Icons.settings_sharp,
                color: Colors.white,
                size: 35,
              )),
        ],
      ),
    );
  }
}

class ExamPage extends StatefulWidget {
  const ExamPage({Key? key}) : super(key: key);

  @override
  ExamPageState createState() => ExamPageState();
}

class ExamPageState extends State<ExamPage> {
  final fb = FirebaseDatabase.instance;
  var endData;
  var beginData;
  var keyData;

  @override
  Widget build(BuildContext context) {
    final ref = fb.ref().child('vragen');

    return Container(
        child: SingleChildScrollView(
            child: Column(
      children: [
        Padding(
          child: Text("Examenvragen",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          padding: EdgeInsets.all(16.0),
        ),
        Center(
          child: FirebaseAnimatedList(
            query: ref,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
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
                          endData[2],
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      subtitle: new Center(
                        child: Text(
                          endData[3],
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
        Container(
          child: Row(
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AddMultipleChoiceQuestionPage()),
                        );
                      },
                      child: Row(children: [
                        Icon(Icons.add_task_rounded,
                            size: 30, color: Colors.white),
                        Text(
                          '  Meerkeuze',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Open Sans',
                          ),
                        ),
                      ]))),
              Container(
                  height: 75,
                  padding: EdgeInsets.all(15),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red[900],
                        onPrimary: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OpenvraagToevoegenPagina()),
                        );
                      },
                      child: Row(children: [
                        Icon(Icons.add_task_rounded,
                            size: 30, color: Colors.white),
                        Text(
                          '  Open Vraag',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Open Sans',
                          ),
                        ),
                      ]))),
              Container(
                  height: 75,
                  padding: EdgeInsets.all(15),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red[900],
                        onPrimary: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddCodeCheckQuestionPage()),
                        );
                      },
                      child: Row(children: [
                        Icon(Icons.add_task_rounded,
                            size: 30, color: Colors.white),
                        Text(
                          '  Code Check',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Open Sans',
                          ),
                        ),
                      ]))),
              Container(
                  height: 75,
                  padding: EdgeInsets.all(15),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red[900],
                      onPrimary: Colors.white,
                    ),
                    onPressed: () async {
                      if (await FirebaseService.deleteExam()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'De examenvragen werden succesvol verwijderd.')),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TeacherPage()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'De examenvragen kunnen op dit moment niet verwijderd worden.')),
                        );
                      }
                    },
                    child: Icon(Icons.delete, size: 30, color: Colors.white),
                  )),
            ],
          ),
          padding: EdgeInsets.only(top: 45),
        )
      ],
    )));
  }
}

class StudentListPage extends StatefulWidget {
  const StudentListPage({Key? key}) : super(key: key);

  @override
  StudentListPageState createState() => StudentListPageState();
}

class StudentListPageState extends State<StudentListPage> {
  final fb = FirebaseDatabase.instance;
  var endData;
  var beginData;
  var keyData;

  @override
  Widget build(BuildContext context) {
    final ref = fb.ref().child('students');

    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        Padding(
          child: Text("Studenten",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          padding: EdgeInsets.all(16.0),
        ),
        Center(
          child: FirebaseAnimatedList(
            query: ref,
            shrinkWrap: true,
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
                          endData[2],
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      subtitle: new Center(
                        child: Text(
                          endData[0],
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
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              height: 75,
              padding: EdgeInsets.all(15),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red[900],
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchStudent()),
                  );
                },
                child: Icon(Icons.edit, size: 30, color: Colors.white),
              )),
          Container(
              height: 75,
              padding: EdgeInsets.all(15),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red[900],
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StudentToevoegenPagina()),
                  );
                },
                child: Icon(Icons.person_add_alt_rounded,
                    size: 30, color: Colors.white),
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
                  if (await FirebaseService.deleteStudent()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              'De studenten werden succesvol verwijderd.')),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TeacherPage()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              'De studenten kunnen op dit moment niet verwijderd worden.')),
                    );
                  }
                },
                child: Icon(Icons.delete, size: 30, color: Colors.white),
              )),
        ])
      ],
    )));
  }
}

class settingsPage extends StatelessWidget {
  settingsPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final oldPassword = TextEditingController();
  final newPassword = TextEditingController();
  final newPasswordRepeated = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                child: Text("Instellingen",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                padding: EdgeInsets.all(15),
              ),
              Container(
                alignment: Alignment.center,
                width: 400,
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  controller: email,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains("@ap.be")) {
                      return 'AP Email dient correct ingevoerd te worden (e.g. lectorname@ap.be).';
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Email (ter verificatie)",
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.red, width: 2.5),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: 400,
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 8) {
                      return 'Wachtwoord moet ingevuld en minstens 8 karakters zijn.';
                    }
                    return null;
                  },
                  controller: oldPassword,
                  obscureText: true,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Oud wachtwoord",
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.red, width: 2.5),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: 400,
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 8) {
                      return 'Wachtwoord moet ingevuld en minstens 8 karakters zijn.';
                    }
                    return null;
                  },
                  controller: newPassword,
                  obscureText: true,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Nieuw wachtwoord",
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.red, width: 2.5),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: 400,
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 8) {
                      return 'Wachtwoord moet ingevuld en minstens 8 karakters zijn.';
                    } else if (value != newPassword.text) {
                      return 'Wachtwoord komt niet overeen met het nieuwe wachtwoord.';
                    }
                    return null;
                  },
                  controller: newPasswordRepeated,
                  obscureText: true,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Herhaling nieuw wachtwoord",
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.red, width: 2.5),
                    ),
                  ),
                ),
              ),
              Container(
                child: Row(
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
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                if (await FirebaseService.authorizeTeacher(
                                    email.text, oldPassword.text)) {
                                  if (newPassword.text ==
                                      newPasswordRepeated.text) {
                                    if (await FirebaseService.updateTeacher(
                                        email.text, newPassword.text)) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Het wachtwoord werd gewijzigd.')),
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
                                                'Wachtwoord kon niet worden gewijzigd vanwege interne fouten.')),
                                      );
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Nieuw wachtwoord komt niet overeen met het herhaalde wachtwoord.')),
                                    );
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Email/wachtwoord-combinatie wordt niet herkend.')),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Gegevens moeten correct ingevuld worden.')),
                                );
                              }
                            },
                            child: Row(children: [
                              Text(
                                'Wijzig',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'Open Sans',
                                ),
                              ),
                            ]))),
                    Container(
                        height: 75,
                        padding: EdgeInsets.all(15),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 79, 79, 79),
                              onPrimary: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StartingPage()),
                              );
                            },
                            child: Row(children: [
                              Text(
                                'Uitloggen',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'Open Sans',
                                ),
                              ),
                            ]))),
                  ],
                ),
                padding: EdgeInsets.only(top: 25),
              )
            ],
          ),
        ),
      ),
    );
  }
}
