import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tehjumbofirebase/firebase_options.dart';
import 'package:tehjumbofirebase/view/SplashPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Es Teh Jumbo',
        debugShowCheckedModeBanner: false,
        home: const SplashScreen());
  }
}
