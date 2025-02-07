import 'package:contineu/screens/login_screen.dart';
import 'package:contineu/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: FilledButton(
          onPressed: () async {
            await AuthService().signOut().whenComplete(() {
              Navigator.of(context).pushReplacement(
                  CupertinoPageRoute(builder: (context) => LoginScreen()));
            });
          },
          child: Text("Signout"),
        ),
      ),
    );
  }
}
