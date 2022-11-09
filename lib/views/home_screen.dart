import 'package:flutter/material.dart';
import 'package:learn_zulu/controlers/home_pages_controler.dart';


import 'package:provider/provider.dart';
class HomeScreen extends StatefulWidget {
  const  HomeScreen({Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {





  @override
  Widget build(BuildContext context) {
    var homeControler=Provider.of<HomePageControler>(context);
    return Scaffold(


        body:homeControler.pages[homeControler.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: homeControler.currentIndex,
        onTap: homeControler.onTapBar ,
        items: const [
          BottomNavigationBarItem(icon:    Icon(Icons.home),label:  "Home"),
          BottomNavigationBarItem(icon:    Icon(Icons.translate),label:  "Translator"),
          BottomNavigationBarItem(icon:   Icon(Icons.report),label:  "About",),

      ],),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}


