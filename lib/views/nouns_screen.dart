import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:learn_zulu/controlers/mobile_ads_controler.dart';
import 'package:learn_zulu/services/audio_player.dart';
import 'package:get/instance_manager.dart';
import 'package:provider/provider.dart';

import '../models/audios_list_model.dart';
import '../models/words_list_model.dart';



class NounsScreen extends StatefulWidget {
  const  NounsScreen({Key? key}) : super(key: key);

  @override
  State<NounsScreen> createState() => _NounsScreenState();
}

class _NounsScreenState extends State<NounsScreen> {


   final AudioPlayerr audioPlayer=Get.find();

@override
void didChangeDependencies(){
  super.didChangeDependencies();
  final adState=Provider.of<AdState>(context,listen:false);
  adState.initialization.then((value) {
    adState.initBanner(adState.bannerNounsAddUnitId);
  });
}

@override
  Widget build(BuildContext context) {
  final adState=Provider.of<AdState>(context,listen:false);
  var width=MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
              centerTitle:true,
          title:  const Text("Nouns"),
          bottom: const TabBar(tabs: [
            Tab(child: Text("Items" ,),) ,
            Tab(child: Text("Places" ),) ,
           // Tab(child: Text("Pronouns",style: TextStyle(color:Colors.black)),) ,
          ])),
          body:TabBarView(children: [
           Column(
             children: [
               Expanded(
                 child: SizedBox(
                   width:width,
                   child: ListView(
          children: [
            DataTable(
                columnSpacing:width<340? 0:null,
                columns:const [DataColumn(label:Text("English")),
                  DataColumn(label:Text("Zulu")),
                  DataColumn(label:Text("Voice"))
                ],
                rows:List.generate(WordsList().nounsEnglishList.length, (i ) => DataRow(cells: [
                  DataCell(Text(WordsList().nounsEnglishList [i],style:GoogleFonts.getFont("Lato",fontStyle: FontStyle.normal))),
                  DataCell(
                    Text(WordsList().nounsZuluList[i],style:GoogleFonts.getFont("Lato",fontStyle: FontStyle.normal)),
                  ),
                  DataCell(IconButton(icon:const Icon(Icons.record_voice_over_outlined),onPressed: (){
                    audioPlayer.speak(i,AudiosList().itemsAudios);
                  },))
                ]))),
          ],
        ),
                 ),
               ),
               if(adState.bannerAd==null)
               const  SizedBox(height: 50,)

               else
                 SizedBox(height: 50,  child: AdWidget(ad: adState.bannerAd!,),)
             ],
           ),

            Column(
              children: [
                Expanded(
                  child: SizedBox(
                    width:MediaQuery.of(context).size.width,
                    child: ListView(
          children: [
            DataTable(
                columnSpacing:width<340? 0:null,
                columns:const [DataColumn(label:Text("English")),
                  DataColumn(label:Text("Zulu")),
                  DataColumn(label:Text("Voice"))
                ],
                rows:List.generate(WordsList().placesEnglishList.length, (i ) => DataRow(cells: [
                  DataCell(Text(WordsList().placesEnglishList[i ],style:GoogleFonts.getFont("Lato",fontStyle: FontStyle.normal))),
                  DataCell(
                    Text(WordsList().placesZuluList[i],style:GoogleFonts.getFont("Lato",fontStyle: FontStyle.normal)),
                  ),
                  DataCell(IconButton(icon:const Icon(Icons.record_voice_over_outlined),onPressed: (){
                    audioPlayer.speak(i,AudiosList().placesAudios);
                  },))
                ]))),

          ],
        ),
                  ),
                ),
                if(adState.bannerAd==null)
                  const  SizedBox(height: 50,)

                else
                  SizedBox(height: 50,  child: AdWidget(ad: adState.bannerAd!,),)
              ],
            ),


          ],)
      ),
    );
  }
}
