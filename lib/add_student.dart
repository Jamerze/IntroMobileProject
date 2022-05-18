import 'package:flutter/material.dart';
import 'package:startup_namer/firebase_service.dart';
import 'package:startup_namer/lector.dart';

class StudentToevoegenPagina extends StatelessWidget {
  StudentToevoegenPagina({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final studentCSVInfo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Examinator",
              style: TextStyle(
                  fontFamily: 'Open Sans', fontWeight: FontWeight.bold)),
          backgroundColor: Colors.red[900],
          centerTitle: true,
          leading: Image.asset("../assets/AP_logo_letters_rgb.jpg"),
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
                            'Student Toevoegen',
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
                            controller: studentCSVInfo,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !value.contains(";")) {
                                return 'Er moet csv data toegevoegd worden.';
                              }
                              return null;
                            },
                            maxLines: 7,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: "Student CSV Data",
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
                            height: 75,
                            padding: EdgeInsets.all(15),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red[900],
                                onPrimary: Colors.white,
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  var csvData = studentCSVInfo.text.split("\n");
                                  var addedSuccessfully = false;
                                  //Remove Header fields if present
                                  var firstData = csvData[0].split(";");
                                  if ((!firstData[0].contains('s') ||
                                          firstData[0].length != 7 ||
                                          int.tryParse(firstData[0]
                                                  .substring(1, 7)) ==
                                              null) &&
                                      (!firstData[1].contains('s') ||
                                          firstData[1].length != 7 ||
                                          int.tryParse(firstData[1]
                                                  .substring(1, 7)) ==
                                              null)) {
                                    csvData.removeAt(0);
                                  }

                                  //Process CSV Data
                                  var indexStudentId = 0;
                                  var indexStudentName = 1;
                                  while(csvData.contains("")){
                                    csvData.remove("");
                                  }
                                  
                                  csvData.forEach((element) async {
                                    if (element.contains(";")) {
                                      var data = element.split(";");
                                      if (data[0].length != 0 &&
                                          data[1].length != 0) {
                                        if (data[1].contains('s') &&
                                            data[1].length == 7 &&
                                            int.tryParse(
                                                    data[1].substring(1, 7)) !=
                                                null) {
                                          indexStudentId = 1;
                                          indexStudentName = 0;
                                        } else {
                                          indexStudentId = 0;
                                          indexStudentName = 1;
                                        }
                                        print(data[indexStudentId]);
                                        print(data[indexStudentName]);
                                        if (await FirebaseService
                                            .studentToevoegen(
                                                data[indexStudentId],
                                                data[indexStudentName])) {
                                          if (csvData.last == element) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      'De student(en) werd(en) succesvol toegevoegd.')),
                                            );
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LectorPage()),
                                            );
                                          }
                                        } else {
                                          if (csvData.last == element) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      'De student kon niet toegevoegd worden vanwege interne fouten.')),
                                            );
                                          }
                                        }
                                      }
                                    }
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Student(en) kon(den) niet toegevoegd worden vanwege fouten.')),
                                  );
                                }
                              },
                              child: Text(
                                'Voeg Student toe',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'Open Sans',
                                ),
                              ),
                            ))
                      ]),
                ]))));
  }
}
