import 'package:flutter/material.dart';
import 'package:fuel_calc/themes/dark_theme.dart';
import 'package:fuel_calc/themes/light_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {

  ThemeProvider() {
    initTheme();
  }

  void initTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool isDarkMode = preferences.getBool("isdarkmode") ?? false;

    debugPrint("The value of the isDarkMode preference is $isDarkMode");

    if (isDarkMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
  
  ThemeData _themedata = lightMode;


  ThemeData get themeData => _themedata;

  void saveTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isdarkmode", !value);
    debugPrint("Changed isdarkmode preference to ${!value}");
    debugPrint(prefs.getBool("isdarkmode").toString());
  }

  set themeData(ThemeData themedata) {
    _themedata = themedata;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themedata == darkMode){
       themeData = lightMode;
       saveTheme(true);
    } else {
       themeData = darkMode;
       saveTheme(false);
    }
    notifyListeners();
  }
}
