import 'package:flutter/material.dart';
import 'package:startup_namer/codecheckvraagtoevoegen.dart';
import 'package:startup_namer/meerkeuzevraagtoevoegen.dart';
import 'package:startup_namer/openvraagtoevoegen.dart';

class LectorPage extends StatefulWidget {
  const LectorPage({Key? key}) : super(key: key);

  @override
  _LectorPageState createState() => _LectorPageState();
}

class _LectorPageState extends State<LectorPage> {
  int pageIndex = 0;

  final pages = [
    const ExamenPagina(),
    const StudentenLijstPagina(),
    const InstellingenPagina(),
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
        leading: Image.asset("../assets/AP_logo_letters_rgb.jpg"),
        leadingWidth: 70,
      ),
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

class ExamenPagina extends StatelessWidget {
  const ExamenPagina({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 45),
          child: DataTable(
            columns: [
              DataColumn(
                  label: Text('VraagNr',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.red[900]))),
              DataColumn(
                  label: Text('Titel',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.red[900]))),
              DataColumn(
                  label: Text('Type',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.red[900]))),
              DataColumn(
                  label: Text('Opties',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.red[900]))),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Verbeter deze foutieve C# code')),
                DataCell(Text('Code Check')),
                DataCell(Row(children: [
                  Icon(Icons.edit),
                  Icon(Icons.delete_forever_rounded)
                ])),
              ]),
              DataRow(cells: [
                DataCell(Text('2')),
                DataCell(Text('Wat is SOP?')),
                DataCell(Text('Open Vraag')),
                DataCell(Row(children: [
                  Icon(Icons.edit),
                  Icon(Icons.delete_forever_rounded)
                ])),
              ]),
              DataRow(cells: [
                DataCell(Text('3')),
                DataCell(Text('Wat zijn voordelen van Angular?')),
                DataCell(Text('Meerkeuze')),
                DataCell(Row(children: [
                  Icon(Icons.edit),
                  Icon(Icons.delete_forever_rounded)
                ])),
              ]),
            ],
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
                                            MeerkeuzevraagToevoegenPagina()),
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
                                        builder: (context) =>
                                            OpenvraagToevoegenPagina()),
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
                                        builder: (context) =>
                                            CodecheckvraagToevoegenPagina()),
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
            ],
          ),
          padding: EdgeInsets.only(top: 45),
        )
      ],
    ));
  }
}

class StudentenLijstPagina extends StatelessWidget {
  const StudentenLijstPagina({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
        child: Column(
      children: [
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
              DataColumn(
                  label: Text('Opties',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.red[900]))),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Stephen')),
                DataCell(Row(children: [
                  Icon(Icons.edit),
                  Icon(Icons.delete_forever_rounded)
                ])),
              ]),
              DataRow(cells: [
                DataCell(Text('5')),
                DataCell(Text('John')),
                DataCell(Row(children: [
                  Icon(Icons.edit),
                  Icon(Icons.delete_forever_rounded)
                ])),
              ]),
              DataRow(cells: [
                DataCell(Text('10')),
                DataCell(Text('Harry')),
                DataCell(Row(children: [
                  Icon(Icons.edit),
                  Icon(Icons.delete_forever_rounded)
                ])),
              ]),
              DataRow(cells: [
                DataCell(Text('15')),
                DataCell(Text('Peter')),
                DataCell(Row(children: [
                  Icon(Icons.edit),
                  Icon(Icons.delete_forever_rounded)
                ])),
              ]),
            ],
          ),
        ),
        Container(
          child: Icon(Icons.person_add_alt_rounded,
              size: 50, color: Colors.red[900]),
          padding: EdgeInsets.only(top: 45),
        )
      ],
    ));
  }
}

class InstellingenPagina extends StatelessWidget {
  const InstellingenPagina({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffC4DFCB),
      child: Center(
        child: Text(
          "Instellingen",
          style: TextStyle(
            color: Colors.red[900],
            fontSize: 45,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
