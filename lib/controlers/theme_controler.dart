

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeChanger extends ChangeNotifier{

  var light=ThemeData.light().copyWith(
      //primaryColor:Colors.red,
          colorScheme:ColorScheme.fromSwatch(primarySwatch:Colors.deepPurple)
  );
  var dark=ThemeData.dark();
   ThemeData _themeData=ThemeData.light();

  ThemeData get getTheme=>_themeData;
  ThemeChanger({ required bool isDarkMode}){

    _themeData = isDarkMode ? dark:light;
  }
  Future<void> setTheme( ) async{
    SharedPreferences prefs= await  SharedPreferences.getInstance();
  if(_themeData==dark){
    _themeData=light;
  prefs.setBool("isDarkMode", false);
  }else{
    _themeData=dark;
    prefs.setBool("isDarkMode", true);
  }
    notifyListeners();
  }
}