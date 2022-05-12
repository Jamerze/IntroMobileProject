import 'package:flutter/material.dart';
import 'package:startup_namer/firebase_service.dart';
import 'package:startup_namer/lector.dart';

class StudentToevoegenPagina extends StatelessWidget {
  StudentToevoegenPagina({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final studentenNr = TextEditingController();
  final studentenNaam = TextEditingController();

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
                            controller: studentenNr,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !value.contains('s') || value.length != 7 || int.tryParse(value.substring(1,7)) == null) {
                                return 'Vul een studentenNr in (eg. s345765)';
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: "StudentenNr",
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
                            controller: studentenNaam,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 4 || !value.contains(" ")) {
                                return 'Vul de voornaam en achternaam van de student in.';
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: "StudentenNaam",
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
                                      // If the form is valid, display a snackbar. In the real world,
                                      // you'd often call a server or save the information in a database.
                                      if (await FirebaseService.studentToevoegen(
                                    studentenNr.text,
                                    studentenNaam.text)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'De student werd succesvol toegevoegd.')),
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LectorPage()),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'De student kon niet toegevoegd worden vanwege interne fouten.')),
                                  );
                                }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Student kon niet toegevoegd worden vanwege fouten.')),
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
