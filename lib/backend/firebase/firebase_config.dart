import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCagnBbI6Ppm-la4QkfrFud7WCqvmu3NSA",
            authDomain: "shelfsaver-e6540.firebaseapp.com",
            projectId: "shelfsaver-e6540",
            storageBucket: "shelfsaver-e6540.firebasestorage.app",
            messagingSenderId: "322514767622",
            appId: "1:322514767622:web:27048d83f9257a7c0e1887",
            measurementId: "G-JH57G74SVE"));
  } else {
    await Firebase.initializeApp();
  }
}
