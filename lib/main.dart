import 'package:firebase_core/firebase_core.dart';
import 'package:firebasemastery/practice/firebase_options.dart';
import 'package:firebasemastery/profile/categoryFirebase.dart';
import 'package:firebasemastery/profile/categoryView.dart';
// import 'package:firebasemastery/profile/categoryView.dart';

import 'package:firebasemastery/profile/homeScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const categoryFirebase(),
    );
  }
}
