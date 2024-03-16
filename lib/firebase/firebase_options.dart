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
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDOARdyOtUxL3GE0tVtX-9CCPg43gAvVlI',
    appId: '1:244492497511:web:819dadaa78a3818dc59ac2',
    messagingSenderId: '244492497511',
    projectId: 'social-app-bdfda',
    authDomain: 'social-app-bdfda.firebaseapp.com',
    storageBucket: 'social-app-bdfda.appspot.com',
    measurementId: 'G-71HGYG0YCC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCS7rreeKbJ3nOpYMJxzBMJMnvB-Y0VJGo',
    appId: '1:244492497511:android:2461fcaca6fe1009c59ac2',
    messagingSenderId: '244492497511',
    projectId: 'social-app-bdfda',
    storageBucket: 'social-app-bdfda.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBZDglLkjPeYdIozXX1qdLmjmFwWKx7wfI',
    appId: '1:244492497511:ios:5f126bd478f2dbf2c59ac2',
    messagingSenderId: '244492497511',
    projectId: 'social-app-bdfda',
    storageBucket: 'social-app-bdfda.appspot.com',
    iosBundleId: 'com.example.socialApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBZDglLkjPeYdIozXX1qdLmjmFwWKx7wfI',
    appId: '1:244492497511:ios:3938bdf19c2e0f46c59ac2',
    messagingSenderId: '244492497511',
    projectId: 'social-app-bdfda',
    storageBucket: 'social-app-bdfda.appspot.com',
    iosBundleId: 'com.example.socialApp.RunnerTests',
  );
}
