import 'package:contineu/services/auth_service.dart';
import 'package:contineu/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.transparent,
        border: null,
        leading: Text(
          "RESET PASSWORD",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                  "Please provide the email so that we can send an email to you to reset your password"),
              SizedBox(
                height: 30,
              ),
              CustomCupertinoTextField(
                controller: _emailController,
                hintText: "Enter your email",
              ),
              SizedBox(height: 30,),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: 50,
                child: FilledButton(
                  onPressed: () async {
                    print("the email is ${_emailController.text}");
                    await AuthService()
                        .resetPassword(_emailController.text)
                        .then((_) {
                      Navigator.of(context).pop();
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
                  child: Text("Send Email"),
                ),
              ),
            ]),
      ),
    );
  }
}
