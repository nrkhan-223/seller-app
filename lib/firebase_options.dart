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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCx3aG-MbHvOVxDGdLlX4XRsDAl_Hh3mms',
    appId: '1:759102557567:web:da602d49595701a75dde4a',
    messagingSenderId: '759102557567',
    projectId: 'online-shop-12a47',
    authDomain: 'online-shop-12a47.firebaseapp.com',
    storageBucket: 'online-shop-12a47.appspot.com',
    measurementId: 'G-6JJ7X8LYHV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAX-tB8jy8yPsLWLV2QGRNbomCFbv4Q_TM',
    appId: '1:759102557567:android:8df6692ffb5651605dde4a',
    messagingSenderId: '759102557567',
    projectId: 'online-shop-12a47',
    storageBucket: 'online-shop-12a47.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDlPsKxvwdO_Ny4qylQf9VOFVSz0_jxAuE',
    appId: '1:759102557567:ios:b21c30922bbb43de5dde4a',
    messagingSenderId: '759102557567',
    projectId: 'online-shop-12a47',
    storageBucket: 'online-shop-12a47.appspot.com',
    iosClientId: '759102557567-srq7soc0i0dierhe8dp80nic3bo58qa0.apps.googleusercontent.com',
    iosBundleId: 'com.example.sellerApp',
  );
}
