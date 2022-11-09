/*

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:learn_zulu/views/home_screen.dart';
 class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
   super.initState();

   _navigateToHome();
  }
  Future<Duration>  dur() async{
    return await Future.delayed(const Duration(milliseconds: 2000));
  }
  _navigateToHome () async{


    WidgetsBinding.instance.addPostFrameCallback( (dur) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));});


  }
  @override
  Widget build(BuildContext context) {
    return const   Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(child:

           Text("Learn Zulu Fast",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30.0,color:Colors.deepOrange )),

           ),
    );
  }
}
*/
