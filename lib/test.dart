import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startup_namer/firebase_service.dart';
import 'package:startup_namer/lector.dart';
import 'package:startup_namer/studenttoevoegen.dart';
import 'package:startup_namer/test2.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final fb = FirebaseDatabase.instance;
  TextEditingController second = TextEditingController();

  TextEditingController third = TextEditingController();
  var l;
  var g;
  var k;
  @override
  Widget build(BuildContext context) {
    final ref = fb.ref().child('students');

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
      body: Column(children: [
        Padding(child: Text("Studenten", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)), padding: EdgeInsets.all(16.0),),
        Center(child: 
      FirebaseAnimatedList(
        query: ref,
        shrinkWrap: true,
        itemBuilder: (context, snapshot, animation, index) {
          var v =
              snapshot.value.toString(); // {subtitle: webfun, title: subscribe}
          
          g = v.replaceAll(
              RegExp("{|}|subtitle: |title: "), ""); // webfun, subscribe
          g.trim();

          l = g.split(','); // [webfun,  subscribe}]

          return GestureDetector(
            onTap: () {
              setState(() {
                k = snapshot.key;
              });

            },
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 300, right: 300,top: 5, bottom: 5),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: Colors.red[900],
                  title: new Center(child:Text(
                    l[1],
                    // 'dd',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),),
                  subtitle: new Center(child:Text(
                    l[0],
                    // 'dd',

                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
                  ),),
                ),
              ),
            ),
          );
        },
      ),),
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
                      if (await FirebaseService.studentenVerwijderen()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'De studenten werden succesvol verwijderd.')),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LectorPage()),
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
      ],)
    );
  }

  upd() async {
    DatabaseReference ref1 = FirebaseDatabase.instance.ref("todos/$k");

// Only update the name, leave the age and address!
    await ref1.update({
      "title": second.text,
      "subtitle": third.text,
    });
    second.clear();
    third.clear();
  }
}