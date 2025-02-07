import 'package:contineu/screens/home_screen.dart';
import 'package:contineu/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: "Cupertino",
      theme: CupertinoThemeData(
        brightness: Brightness.light
      ),
      home: LoginScreen()
    );
  }
}
