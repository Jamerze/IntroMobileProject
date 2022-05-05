import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:startup_namer/codecheckvraagtoevoegen.dart';
import 'package:startup_namer/firebase_options.dart';
import 'package:startup_namer/homepage.dart';
import 'package:startup_namer/meerkeuzevraagtoevoegen.dart';
import 'package:startup_namer/openvraagtoevoegen.dart';
import 'package:startup_namer/lector.dart';
import 'package:startup_namer/test.dart';

import 'lectorlogin.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Examen Monitoring Tool',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LectorLogin(),
    );
  }
}
