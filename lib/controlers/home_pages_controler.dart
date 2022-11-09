import 'package:flutter/material.dart';
import 'package:learn_zulu/views/about_screen.dart';

import 'package:learn_zulu/views/home_pages.dart';

import '../views/translator_screen.dart';
class HomePageControler extends ChangeNotifier{


  int currentIndex=0;
  final List<Widget> _pages=[
    const HomePages(),
      const TranslatorScreen(),
    const AboutScreen()
  ];
get pages=>_pages;
  void onTapBar(int index){
    currentIndex=index;
    notifyListeners();
  }

}