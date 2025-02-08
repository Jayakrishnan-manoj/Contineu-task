import 'package:contineu/screens/auth/login_screen.dart';
import 'package:contineu/services/auth_service.dart';
import 'package:contineu/widgets/settings_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.transparent,
        border: null,
        middle: Text(
          "Settings",
          style: TextStyle(fontSize: 32),
        ),
      ),
      child: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: Column(
              children: [
                SettingsTile(
                  title: "Logout",
                  trailing: Icon(
                    CupertinoIcons.person_badge_minus,
                    color: CupertinoColors.systemRed,
                  ),
                  onTap: () async {
                    await AuthService().signOut().whenComplete(() {
                      Navigator.of(context).pushReplacement(
                        CupertinoPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    });
                  },
                ),
                SettingsTile(
                  onTap: null,
                  trailing: CupertinoSwitch(
                    value: true,
                    onChanged: (_) {},
                  ),
                  title: "Dark Mode",
                )
              ],
            )),
      ),
    );
  }
}
