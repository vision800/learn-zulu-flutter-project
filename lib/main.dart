
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:learn_zulu/controlers/home_pages_controler.dart';
import 'package:learn_zulu/controlers/mobile_ads_controler.dart';
import 'package:learn_zulu/controlers/theme_controler.dart';
import 'package:learn_zulu/controlers/trasnlator_provider_controler.dart';


import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:learn_zulu/views/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:learn_zulu/services/audio_player.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs= await  SharedPreferences.getInstance();
  final initFuture=MobileAds.instance.initialize();
  //adding google fonts licenses
LicenseRegistry.addLicense(()async*{
  final licence= await rootBundle.loadString('google_fonts/OFL.txt');
  yield LicenseEntryWithLineBreaks(['google_fonts'],licence);
});
  runApp(
      MultiProvider(providers:[
       
    ChangeNotifierProvider(create: (_)=>ThemeChanger(isDarkMode: prefs.getBool("isDarkMode")?? false)),
     ChangeNotifierProvider(create: (_)=>TranslatorProvider()),
    ChangeNotifierProvider(create: (_)=>HomePageControler()),
        ChangeNotifierProvider(create: (_)=>AdState(initFuture) ),

  ] ,
  child: MyApp(),));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.


  final  audioControler = Get.put(AudioPlayerr());

  @override
  Widget build(BuildContext context) {


    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeChanger>(context).getTheme,

      home:  const MyHomePage(  ),
    );


  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  const HomeScreen();
  }
}
