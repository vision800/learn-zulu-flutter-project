import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:learn_zulu/controlers/mobile_ads_controler.dart';
import 'package:learn_zulu/services/audio_player.dart';
import 'package:get/instance_manager.dart';
import 'package:learn_zulu/models/words_list_model.dart';
import 'package:provider/provider.dart';

import '../models/audios_list_model.dart';

class FamilyScreen extends StatefulWidget {
    const FamilyScreen({Key? key}) : super(key: key);

  @override
  State<FamilyScreen> createState() => _FamilyScreenState();
}

class _FamilyScreenState extends State<FamilyScreen> {


 final AudioPlayerr audioPlayer=Get.find();

 @override
 void initState(){
   super.initState();
   Future((){
     var width=MediaQuery.of(context).size.width;
   const snackBar=    SnackBar(content:  Text("Rotate the Screen If you cannot see verything  "),
         duration:  Duration(seconds:1));
    if(width<340)  ScaffoldMessenger.of(context).showSnackBar(snackBar);

   });
 }

 @override
  void didChangeDependencies(){
   super.didChangeDependencies();

   final adState=Provider.of<AdState>(context,listen:false);
   adState.initialization.then((value) {
      adState.initBanner(adState.bannerFamilyAddUnitId);
   });
 }


  @override
  Widget build(BuildContext context) {
    final adState=Provider.of<AdState>(context,listen:false);

    return Scaffold(
      appBar: AppBar(title:const Text("Family") ,),
      body:   Column(
          children: [
            Expanded(
                child: SizedBox(

                width:MediaQuery.of(context).size.width,
                child: ListView(

                  children: [
                    DataTable(
                          columnSpacing:0,
                          columns:const [DataColumn(label:Text("English")),
                        DataColumn(label:Text("Zulu")),
                        DataColumn(label:Text("Voice"))
                      ],
                          rows:List.generate(WordsList().familyList.length, (i ) => DataRow(cells: [
                            DataCell(Text(WordsList().familyList[i ],style:GoogleFonts.getFont("Lato",fontStyle: FontStyle.normal))),
                            DataCell(
                                Text(WordsList().zuluFamilyList[i],style:GoogleFonts.getFont("Lato",fontStyle: FontStyle.normal)),
                              ),
                            DataCell(IconButton(icon:const Icon(Icons.record_voice_over_outlined),onPressed: (){
                              audioPlayer.speak(i,AudiosList().familuAudios);
                            },))
                          ]))),

                  ],
                ),
              ),
            ),
           if(adState.bannerAd==null  )
         const  SizedBox(height: 50,)

           else
             SizedBox(height: 50,  child: AdWidget(ad: adState.bannerAd!,),)
          ],
        ),

    );
  }
}
