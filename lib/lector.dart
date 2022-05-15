import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Lector {
  static Lector _currentLector = Lector("");
  String name = "";

  Lector(n) {
    name = n;
  }

  static void setCurrentLector(lector) {
    _currentLector = lector;
  }

  static Lector getCurrentLector() {
    return _currentLector;
  }
}

class LectorPage extends StatelessWidget {
  const LectorPage({Key? key}) : super(key: key);

  static const String _title = 'Home';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Column(
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
                      onPressed: () {},
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
                      onPressed: () {},
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
                      onPressed: () {},
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
    ),
    Column(
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
    ),
    new FlutterMap(
        options:
            new MapOptions(center: new LatLng(40.71, -74.00), minZoom: 10.0),
        layers: [
          new TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          new MarkerLayerOptions(markers: [
            new Marker(
                width: 45.0,
                height: 45.0,
                point: new LatLng(40.71, -74.00),
                builder: (context) => new Container(
                      child: IconButton(
                        icon: Icon(Icons.location_on),
                        color: Colors.red,
                        iconSize: 45.0,
                        onPressed: () {
                          print('Marker tapped');
                        },
                      ),
                    ))
          ])
        ])
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
              Lector.getCurrentLector().name,
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Open Sans',
              ),
            ),
          ]),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_note),
            label: 'Examenvragen',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Studenten',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_sharp),
            label: 'Instellingen',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 158, 14, 14),
        onTap: _onItemTapped,
      ),
    );
  }
}
