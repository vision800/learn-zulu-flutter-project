import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../controlers/trasnlator_provider_controler.dart';
class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  void initState(){
    super.initState();
    var translator=Provider.of<TranslatorProvider>(context);
    translator.validate=false;
    Future((){

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    });
  }
  @override
  Widget build(BuildContext context) {
    String version="1.0.0";
    String email=" netshokotshokovision112@gmail.com";
    return Scaffold(
      appBar: AppBar( title: const Text("About"),),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        width:MediaQuery.of(context).size.width,
        child:  ListView(
          children: [

                      Center(child:Container(padding: const EdgeInsets.only( left: 100.0,right: 100.0,bottom: 25.0,top: 25.0,),
                          child:Image.asset("assets/images/appImage.png"))),


                   Center(
                    child:    RichText(text:  TextSpan(
                        text: "Learn Zulu Fast ",
                        style: const TextStyle(color: Colors.purple,fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          style:  Theme.of(context).textTheme.bodyText2,
                            text:"is the application that offers Isizulu basics amd the main features of this application are the translator"
                            " that translate any words from english to zulu and also translate zulu words to english words with the use of internet connection and the last feature is the audio player that plays the audio for each corresponding zulu words."

                        )
                      ]

                    ),

                    ),

                ),
                  const SizedBox(height: 5.0,),
                  const Divider(thickness: 3.0,),

                  const SizedBox(height: 5.0,),
                  Row(
                    children:  [
                        Text("Version $version",style:const TextStyle(fontWeight: FontWeight.bold,) ),
                    ],
                  ),
                  const Divider(thickness: 3.0,),
                  const SizedBox(height: 5.0,),
                  Row(
                    children: const [
                      Text("Contact me",style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),


         GestureDetector(child:  Text(email),onTap:(){
           FlutterClipboard.copy(email ).then((value){
             return  Get.snackbar("Email", "Copied Succesfully",snackPosition: SnackPosition.BOTTOM);
           });
         }),


            const SizedBox(height: 5.0,),
            const Divider(thickness: 3.0,),
              const Text("Disclaimer",style: TextStyle(fontWeight: FontWeight.bold ),),
                const Text("The information provided on this mobile application is for general informational purpose only. "
                    "I am doing my best to prepare the best content of this app.However, Learn Zulu fast cannot warrantly the expressions and suggestions of the contents, as well as accuracy.In addition to the extent permitted by the law Learn Zulu Fast shall not be responsible for any loses and/or damages due to the usage of the information on this app."
                    "Some of the information provided on this application does not belong to me it belongs to different sources  for example images/icons and also some zulu words."),

            const SizedBox(height: 3.0,),
            const Divider(thickness: 2.0,),
                Row(
                  children: const [
                    Text("Consent",style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),

                    const Text("By using my app ,you hereby consent to my disclaimer and agree to its terms."),

   const Divider(thickness:3.0),
         GestureDetector(
           child:const ListTile(
            leading:
            Icon(Icons.report),
             title: Text("View Licences"),


           ),
           onTap:(){
    showLicensePage(context: context,applicationName:"Learn Zulu Fast");
    }


        ),
    ]
        ),
         ),
    );
  }
}
