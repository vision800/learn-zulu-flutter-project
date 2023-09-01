
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:learn_zulu/views/body_parts_screen.dart';
import 'package:learn_zulu/views/conjuctions_screen.dart';
import 'package:learn_zulu/views/dictionary_screen.dart';
import 'package:learn_zulu/views/nouns_screen.dart';
import 'package:learn_zulu/views/numbers_screen.dart';
import 'package:learn_zulu/views/pronouns_screen.dart';
import 'package:learn_zulu/views/timedays_screen.dart';

import 'package:learn_zulu/views/family_screen.dart';
import 'package:learn_zulu/views/greetings_screen.dart';
import 'package:learn_zulu/views/daily_phrases_screen.dart';
import 'package:learn_zulu/views/foods_screen.dart';
import 'package:learn_zulu/views/colors_screen.dart';

import 'package:learn_zulu/controlers/theme_controler.dart';

import 'package:provider/provider.dart';

import '../controlers/trasnlator_provider_controler.dart';


class HomePages extends StatefulWidget {
  const HomePages({Key? key}) : super(key: key);

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
   @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
     var translator=Provider.of<TranslatorProvider>(context);
    translator.validate=false;
    super.didChangeDependencies();
  }
  @override
  void initState(){
     
    super.initState();
    
    Future((){

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    });
  }
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<ThemeChanger>(context);
       var  pageTranstion= Transition.zoom;

    return Scaffold(
        appBar: AppBar(

          title:const Text("Home"),

          actions: [
            IconButton(onPressed: ( ){
              provider.setTheme();
            }, icon:  Icon(provider.getTheme==provider.light ? Icons.brightness_2_outlined:Icons.brightness_2))
          ],
        ),
        body:GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 6.0,
            crossAxisSpacing  :2.0,
        children :[
          GestureDetector(
            onTap: (){
              Get.to(()=>const GreetingScreen(),transition: pageTranstion,duration: const Duration(seconds:1));
            },
            child:   Card(
              elevation:10,
              //shadowColor: Colors.black45,
              child: GridTile(
                  footer: const Padding(
                    padding:   EdgeInsets.all(8.0),
                    child: Text("Greetings",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                  child: Container(
                      padding: const EdgeInsets.only(left:20.0,right:20.0),
                      child: Image(image:  const AssetImage("assets/images/handshake.png"),
                        alignment:  Alignment.center,color:provider.getTheme==provider.dark? Colors.white:null,))
              ),
            ),
          ),
          GestureDetector(
            onTap: (){ Get.to(()=>const DailyPhrases(),transition: pageTranstion,duration: const Duration(seconds:1));},
            child:     Card(
              elevation:10,
             // shadowColor: Colors.black45,
              child: GridTile(
                  footer: const Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: Text("DailyPhrases",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  child: Container(
                      padding: const EdgeInsets.only(left:30.0,right:30.0),
                      child: Image.asset("assets/images/training-phrase.png",
                          alignment:  Alignment.center ))
              ),
            ),
          ),
          GestureDetector(
            onTap: (){  Get.to(()=>const FamilyScreen(),transition: pageTranstion,duration: const Duration(seconds:1) );},
            child:     Card(
              elevation:10,
             // shadowColor: Colors.yellow,
              child: GridTile(
                  footer: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Family",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  child: Container(
                      padding: const EdgeInsets.only(bottom: 17.0,left:35.0,right:35.0),
                      child: const Image(image:   AssetImage("assets/images/Family.png"),
                        alignment:  Alignment.center,))
              ),
            ),
          ),
          GestureDetector(
            onTap: (){ Get.to(()=> const TimeDays(),transition: pageTranstion,duration: const Duration(seconds:1));},
            child:    Card(
              elevation:10,
              //shadowColor: Colors.black45,
              child: GridTile(
                  footer: const Padding(
                    padding:   EdgeInsets.all(8.0),
                    child: Text("Time&Days",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  child: Container(
                      padding: const EdgeInsets.only(bottom: 17.0,left:35.0,right:35.0),
                      child: Image.asset("assets/images/Day.png",
                          alignment:  Alignment.center ))
              ),
            ),
          ),


          GestureDetector(
            onTap: (){ Get.to(()=>const BodyParts(),transition: pageTranstion,duration: const Duration(seconds:1));},
            child:    Card(
              elevation:10,

              child: GridTile(
                  footer: const Padding(
                    padding:   EdgeInsets.all(8.0),
                    child: Text("BodyParts",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  child: Container(
                      padding: const EdgeInsets.only(bottom: 35.0,left: 20.0,right: 20.0,top: 20),
                      child: const Image(image: AssetImage("assets/images/bodyParts.png"),
                        alignment:  Alignment.center,))
              ),
            ),
          ),
          GestureDetector(
            onTap: (){ Get.to(()=>const FoodScreen(),transition: pageTranstion,duration: const Duration(seconds:1));},
            child:    Card(
              elevation:10,

              child: GridTile(
                  footer: const Padding(
                    padding:   EdgeInsets.all(8.0),
                    child: Text("Food",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  child: Container(
                      padding: const EdgeInsets.only(bottom: 30.0,left: 20.9,right: 20.0,top: 20.0),
                      child: const Image(image: AssetImage("assets/images/Salad.png"),
                        alignment:  Alignment.center,))
              ),
            ),
          ),
          GestureDetector(
            onTap: (){  Get.to( ()=>const NumbersScreen(),transition: pageTranstion,duration: const Duration(seconds:1));},
            child:   Card(
              elevation:10,

              child: GridTile(
                  footer: const Padding(
                    padding:   EdgeInsets.all(8.0),
                    child: Text("Numbers",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  child: Container(
                      padding: const EdgeInsets.only(left:35.0,right:35.0),
                      child: const Image(image: AssetImage("assets/images/numbers.png"),
                        alignment:  Alignment.center,))
              ),
            ),
          ),
          GestureDetector(
            onTap: (){  Get.to(()=> const NounsScreen(),transition: pageTranstion,duration: const Duration(seconds:1));},
            child:     Card(
              elevation:10,

              child: GridTile(
                  footer: const Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: Text("Nouns",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  child: Container(
                      padding: const EdgeInsets.only(left:30.0,right:30.0),
                      child: Image.asset("assets/images/customer.png",
                          alignment:  Alignment.center ))
              ),
            ),
          ),
          GestureDetector(
            onTap: (){  Get.to(()=> const PronounsScreen(),transition: pageTranstion,duration: const Duration(seconds:1));},
            child:   Card(
              elevation:10,

              child: GridTile(
                  footer: const Padding(
                    padding:   EdgeInsets.all(8.0),
                    child: Text("Pronouns",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  child: Container(
                      padding: const EdgeInsets.only(left:30.0,right:30.0),
                      child: Image.asset("assets/images/medical-card.png",
                          alignment:  Alignment.center ))
              ),
            ),
          ),
          GestureDetector(
            onTap: (){ Get.to(()=>const ConjunctionsScreen(),transition: pageTranstion,duration: const Duration(seconds:1));},
            child:   Card(
              elevation:10,

              child: GridTile(
                  footer: const Padding(
                    padding:   EdgeInsets.all(8.0),
                    child: Text("Conjuctions",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  child: Container(
                      padding: const EdgeInsets.only(left:30.0,right:30.0),
                      child: Image.asset("assets/images/link.png",
                          alignment:  Alignment.center ))
              ),
            ),
          ),
          GestureDetector(
            onTap: (){ Get.to(()=>const ColorsScreen(),transition: pageTranstion,duration: const Duration(seconds:1));},
            child:     Card(
              elevation:10,

              child: GridTile(
                  footer: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Colors",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  child: Container(
                      padding: const EdgeInsets.only(left:30.0,right:30.0),
                      child: const FittedBox(child:Icon(Icons.color_lens ,color: Colors.teal,)))
              ),
            ),
          ),

          GestureDetector(
            onTap: (){ Get.to(()=>const DictionaryScreen(),transition: pageTranstion,duration: const Duration(seconds:1));},
            child:   Card(
              elevation:10,

              child: GridTile(
                  footer: const Padding(
                    padding:   EdgeInsets.all(8.0),
                    child: Text("Verbs",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  child: Container(
                      padding: const EdgeInsets.only(left:30.0,right:30.0),
                      child: Image.asset("assets/images/verbs.png",
                          alignment:  Alignment.center ))
              ),
            ),
          ),

        ]));
  }
}
