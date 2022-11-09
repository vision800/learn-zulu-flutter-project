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
class FoodScreen extends StatefulWidget {
    const FoodScreen({Key? key}) : super(key: key);

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {


    final AudioPlayerr audioPlayer=Get.find();

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    final adState=Provider.of<AdState>(context,listen:false);
    adState.initialization.then((value) {
      adState.initBanner(adState.bannerFoodAddUnitId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final adState=Provider.of<AdState>(context,listen:false);
    var width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const  Text("Food"),),
      body:    Column(
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
                        rows:List.generate(WordsList().foodEnglishList.length, (i ) => DataRow(cells: [
                          DataCell(Text(WordsList().foodEnglishList[i ],style:GoogleFonts.lato())),
                          DataCell(
                            Text(WordsList().foodZuluList[i],style:GoogleFonts.getFont("Lato",fontStyle: FontStyle.normal)),
                          ),
                          DataCell(IconButton(icon:const Icon(Icons.record_voice_over_outlined),onPressed: (){
                            audioPlayer.speak(i,AudiosList().foodAudios);
                          },))
                        ]))),

                  ],
                ),
            ),
          ),
          if(adState.bannerAd==null)
          const  SizedBox(height: 50,)

          else
            SizedBox(height: 50,   child: AdWidget(ad: adState.bannerAd!,),)
        ],
      ),

    );
  }
}
