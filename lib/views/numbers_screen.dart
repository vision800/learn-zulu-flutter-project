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

class NumbersScreen extends StatefulWidget {
  const NumbersScreen({Key? key}) : super(key: key);

  @override
  State<NumbersScreen> createState() => _NumbersScreenState();
}

class _NumbersScreenState extends State<NumbersScreen> {




   final AudioPlayerr audioPlayer=Get.find();

@override
void didChangeDependencies(){
  super.didChangeDependencies();
  final adState=Provider.of<AdState>(context,listen:false);
  adState.initialization.then((value) {
    adState.initBanner(adState.bannerNumbersAddUnitId);
  });
}

  @override
  Widget build(BuildContext context) {
    final adState=Provider.of<AdState>(context,listen:false);
    var width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title:  const Text("Numbers"),),
      body: Column(
        children: [
          Expanded(
           child:ListView(
                children: [
                  SizedBox(
                    width:MediaQuery.of(context).size.width ,
                    child: DataTable(
                        columnSpacing:width<340? 0:null,
                        columns: const [DataColumn(label:Text("Numb")),
                      DataColumn(label:Text("Zulu")),  DataColumn(label:Text("Voice")),],
                        rows:List.generate(WordsList().numbers.length, (i ) => DataRow(cells: [
                          DataCell(Text( "${i+1} ")),

                          DataCell(
                              Text(WordsList().numbers[i],style:GoogleFonts.getFont("Lato",fontStyle: FontStyle.normal)),

                            ),
    DataCell( IconButton(icon: const Icon(Icons.record_voice_over_outlined),onPressed: (){
            audioPlayer.speak(i,AudiosList().numbersAudios);
    },))
                        ]))),
                  ),
                ],
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
