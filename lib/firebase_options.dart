// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    databaseURL:
        'https://exammonitor-9cd77-default-rtdb.europe-west1.firebasedatabase.app/',
    apiKey: 'AIzaSyD6TxpQ_oqjfp2Qev9WFJKSD4juv03--vk',
    appId: '1:1035497989627:web:63f33b6d8231501497d75e',
    messagingSenderId: '1035497989627',
    projectId: 'exammonitor-9cd77',
    authDomain: 'exammonitor-9cd77.firebaseapp.com',
    storageBucket: 'exammonitor-9cd77.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    databaseURL:
        'https://exammonitor-9cd77-default-rtdb.europe-west1.firebasedatabase.app/',
    apiKey: 'AIzaSyCLwlubMSqKExrc_3M75dJMyabhLDDvlRA',
    appId: '1:1035497989627:android:775aabcba22a704397d75e',
    messagingSenderId: '1035497989627',
    projectId: 'exammonitor-9cd77',
    storageBucket: 'exammonitor-9cd77.appspot.com',
  );
}
