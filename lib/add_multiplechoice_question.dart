import 'package:flutter/material.dart';
import 'package:startup_namer/teacher.dart';
import 'firebase_service.dart';

class AddMultipleChoiceQuestionPage extends StatelessWidget {
  AddMultipleChoiceQuestionPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final question = TextEditingController();
  final answers = TextEditingController();
  final correctAnswer = TextEditingController();

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
        body: Form(
            key: _formKey,
            child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(children: [
                  Container(
                    width: 60,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red[900],
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Row(children: [
                          Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.white,
                          ),
                        ])),
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(15),
                          child: Text(
                            'Meerkeuze Vraag Toevoegen',
                            style: TextStyle(
                                color: Colors.red[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 400,
                          padding: EdgeInsets.all(15),
                          child: TextFormField(
                            controller: question,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length <= 5) {
                                return 'Vul een vraag in (min. 5 karakters)';
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: "Titel",
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
                        Container(
                          alignment: Alignment.center,
                          width: 400,
                          padding: EdgeInsets.all(15),
                          child: TextFormField(
                            controller: answers,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !value.contains(";")) {
                                return '4 Antwoorden van elkaar gescheiden met puntkomma (;)';
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: "Antwoorden (4!)",
                              labelStyle: TextStyle(color: Colors.black),
                              enabledBorder: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2.5),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 400,
                          padding: EdgeInsets.all(15),
                          child: TextFormField(
                            controller: correctAnswer,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !answers.text.contains(value)) {
                                return 'Antwoord komt niet in bovenstaande opties voor.';
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: "Correct antwoord",
                              labelStyle: TextStyle(color: Colors.black),
                              enabledBorder: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2.5),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red[900], // background
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (await FirebaseService.addExamQuestion(
                                    answers.text,
                                    correctAnswer.text,
                                    question.text,
                                    "meerkeuze")) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'De vraag werd succesvol toegevoegd.')),
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const TeacherPage()),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'De vraag kon niet toegevoegd worden vanwege interne fouten.')),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'De vraag kon niet toegevoegd worden vanwege fouten in de invoer. Controleer of alles correct aangevuld is.')),
                                );
                              }
                            },
                            child: Icon(Icons.add_comment_rounded,
                                size: 50, color: Colors.white),
                          ),
                          padding: EdgeInsets.only(top: 45),
                        )
                      ]),
                ]))));
  }
}
