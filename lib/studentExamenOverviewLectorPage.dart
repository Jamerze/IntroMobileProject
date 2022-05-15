import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:startup_namer/Classes/student.dart';
import 'package:startup_namer/lector.dart';

class StudentExamenOverview extends StatefulWidget {
  const StudentExamenOverview({Key? key}) : super(key: key);

  @override
  StudentExamenOverviewState createState() => StudentExamenOverviewState();
}

class StudentExamenOverviewState extends State<StudentExamenOverview> {
  final fb = FirebaseDatabase.instance;
  var endData;
  var beginData;
  var keyData;

  var endData2;
  var beginData2;
  var keyData2;

  var studentNr = Student.getCurrentStudent().studentNumber;

  @override
  Widget build(BuildContext context) {
    final ref = fb.ref().child('vragen');
    final ref2 = fb.ref().child('examanswers/$studentNr');
    print("test");
    print(Student.getCurrentStudent().studentNumber);

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
        body: Column(
          children: [
            Container(
                child: Column(
              children: [
                Padding(
                  child: Text("Examenvragen",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
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
              ],
            )),
          Container(
                child: Column(
              children: [
                Padding(
                  child: Text("Antwoorden ($studentNr)",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  padding: EdgeInsets.all(16.0),
                ),
                Center(
                  child: FirebaseAnimatedList(
                    query: ref2,
                    shrinkWrap: true,
                    itemBuilder: (context, snapshot, animation, index) {
                      var snapshotValue = snapshot.value.toString();

                      beginData2 = snapshotValue.replaceAll(
                          RegExp("{|}|subtitle: |title: "), "");
                      beginData2.trim();

                      endData2 = beginData2.split(',');

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
                                  endData2[0],
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
          ],
        ));
  }
}
