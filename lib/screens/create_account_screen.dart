import 'package:contineu/screens/login_screen.dart';
import 'package:contineu/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
   @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.transparent,
        border: null,
        leading: Text("SIGN UP",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
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
            ),
            SizedBox(
              height: 30,
            ),
            CustomCupertinoTextField(
              hintText: "Set a new password",
              isPassword: true,
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: 50,
              child: FilledButton(
                onPressed: () {},
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
                child: Text("Sign Up"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text.rich(TextSpan(
                  text: 'Already have an account? ',
                  children: <InlineSpan>[
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pushReplacement(
                            CupertinoPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                      text: 'Login',
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