// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyAmpviDG7xCGPdagnfziqQR89wxwRA-f74',
    appId: '1:1045583504766:web:83656cabcd4f3b10fa7f2f',
    messagingSenderId: '1045583504766',
    projectId: 'gg1-project',
    authDomain: 'gg1-project.firebaseapp.com',
    storageBucket: 'gg1-project.firebasestorage.app',
    measurementId: 'G-4MPLSL2HW7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB_4l12tpTRex_VWRxyAtWf2B6pXEGS2BU',
    appId: '1:1045583504766:android:cfe7b4813428384bfa7f2f',
    messagingSenderId: '1045583504766',
    projectId: 'gg1-project',
    storageBucket: 'gg1-project.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCXbLti7ZqVXuRzO-bqW8UROZ9z2jm48Vg',
    appId: '1:1045583504766:ios:ba45852fb5d75b20fa7f2f',
    messagingSenderId: '1045583504766',
    projectId: 'gg1-project',
    storageBucket: 'gg1-project.firebasestorage.app',
    iosBundleId: 'com.example.gg',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCXbLti7ZqVXuRzO-bqW8UROZ9z2jm48Vg',
    appId: '1:1045583504766:ios:ba45852fb5d75b20fa7f2f',
    messagingSenderId: '1045583504766',
    projectId: 'gg1-project',
    storageBucket: 'gg1-project.firebasestorage.app',
    iosBundleId: 'com.example.gg',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAmpviDG7xCGPdagnfziqQR89wxwRA-f74',
    appId: '1:1045583504766:web:e7c2d6c76b06fe6efa7f2f',
    messagingSenderId: '1045583504766',
    projectId: 'gg1-project',
    authDomain: 'gg1-project.firebaseapp.com',
    storageBucket: 'gg1-project.firebasestorage.app',
    measurementId: 'G-RYPYKL01LY',
  );
}
