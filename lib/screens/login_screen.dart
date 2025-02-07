// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:contineu/screens/create_account_screen.dart';
import 'package:contineu/screens/home_screen.dart';
import 'package:contineu/services/auth_service.dart';
import 'package:contineu/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.transparent,
        border: null,
        leading: Text(
          "LOGIN",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset("assets/images/contineu_logo.png")),
            SizedBox(
              height: 30,
            ),
            CustomCupertinoTextField(
              hintText: "Enter Email",
              controller: _emailController,
            ),
            SizedBox(
              height: 30,
            ),
            CustomCupertinoTextField(
              hintText: "Enter Password",
              isPassword: true,
              controller: _passwordController,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Forgot Password?",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 14,
                color: CupertinoColors.activeOrange,
                decoration: TextDecoration.underline,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: 50,
              child: FilledButton(
                onPressed: () async {
                  await AuthService()
                      .loginWithEmail(
                          _emailController.text, _passwordController.text)
                      .then((value) {
                    if (value == "logged in") {
                      Navigator.of(context).pushReplacement(
                        CupertinoPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    } else {
                      print(value);
                    }
                  });
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                      CupertinoColors.darkBackgroundGray),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                ),
                child: Text("Login"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text.rich(TextSpan(
                  text: 'Don\'t have an account? ',
                  children: <InlineSpan>[
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pushReplacement(
                            CupertinoPageRoute(
                              builder: (context) => CreateAccountScreen(),
                            ),
                          );
                        },
                      text: 'Create an account',
                      style: TextStyle(
                          color: CupertinoColors.activeOrange,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    )
                  ])),
            ),
          ],
        ),
      ),
    );
  }
}
