import 'package:flutter/material.dart';
import 'package:startup_namer/lector.dart';

class StudentenSelectiePagina extends StatelessWidget {

  StudentenSelectiePagina({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final vraag = TextEditingController();

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
                child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          "Wie ben je?",
                          style: TextStyle(
                            color: Colors.red[900],
                            fontSize: 45,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 45),
                          child: DataTable(
                            columns: [
                              DataColumn(
                                  label: Text('Studentennummer',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red[900]))),
                              DataColumn(
                                  label: Text('Naam',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red[900]))),
                            ],
                            rows: [
                              DataRow(cells: [
                                DataCell(Text('1')),
                                DataCell(Text('Stephen')),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('5')),
                                DataCell(Text('John')),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('10')),
                                DataCell(Text('Harry')),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('15')),
                                DataCell(Text('Peter')),
                              ]),
                            ],
                          ),
                        ),
                        ElevatedButton(
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
                                )
                      ],
                    )))));
  }
}
