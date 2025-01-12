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
    apiKey: 'AIzaSyDvakVQwvszBF6dDJah_Sog0rqcwKkuSHY',
    appId: '1:1078840760756:web:123bed248aec9a81f0fae1',
    messagingSenderId: '1078840760756',
    projectId: 'asignment1-e0e9a',
    authDomain: 'asignment1-e0e9a.firebaseapp.com',
    storageBucket: 'asignment1-e0e9a.appspot.com',
    measurementId: 'G-JZ1PPRG7ET',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAgf_NFNyEPMleAk7SHzmEw712ZVlwX1GM',
    appId: '1:1078840760756:android:242db5972472a0c9f0fae1',
    messagingSenderId: '1078840760756',
    projectId: 'asignment1-e0e9a',
    storageBucket: 'asignment1-e0e9a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAW2T3bjYFEdImEYN9PNcZatN84gW34L2o',
    appId: '1:1078840760756:ios:17aa877cfce5151af0fae1',
    messagingSenderId: '1078840760756',
    projectId: 'asignment1-e0e9a',
    storageBucket: 'asignment1-e0e9a.appspot.com',
    iosBundleId: 'com.example.blackcofferAssignment',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAW2T3bjYFEdImEYN9PNcZatN84gW34L2o',
    appId: '1:1078840760756:ios:82b8363e17075052f0fae1',
    messagingSenderId: '1078840760756',
    projectId: 'asignment1-e0e9a',
    storageBucket: 'asignment1-e0e9a.appspot.com',
    iosBundleId: 'com.example.blackcofferAssignment.RunnerTests',
  );
}
