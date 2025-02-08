import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  // setDarkTheme(bool value) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool("isDarkTheme", value);
  // }

  // Future<bool> getTheme() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getBool("isDarkTheme") ?? false;
  // }

  // Load theme from SharedPreferences
  Future<void> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkTheme = prefs.getBool("isDarkTheme") ?? false;
    notifyListeners();
  }

  // Save theme to SharedPreferences and notify listeners
  void toggleTheme() async {
    _isDarkTheme = !_isDarkTheme;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isDarkTheme", _isDarkTheme);
    notifyListeners();
  }

  static final lightAppTheme = CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: CupertinoColors.systemBlue,
    barBackgroundColor: CupertinoColors.systemGrey6,
    scaffoldBackgroundColor: CupertinoColors.extraLightBackgroundGray,
    textTheme: CupertinoTextThemeData(
      primaryColor: CupertinoColors.black,
      textStyle: TextStyle(fontFamily: "Lato", color: CupertinoColors.black),
    ),
  );

  static final darkAppTheme = CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: CupertinoColors.systemBlue,
    barBackgroundColor: CupertinoColors.black,
    scaffoldBackgroundColor: Colors.black54,
    textTheme: CupertinoTextThemeData(
      primaryColor: CupertinoColors.white,
      textStyle: TextStyle(
        fontFamily: "Lato",
        color: CupertinoColors.white,
      ),
    ),
  );
}
