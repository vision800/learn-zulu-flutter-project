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


class ColorsScreen extends StatefulWidget {
  const ColorsScreen({Key? key}) : super(key: key);

  @override
  State<ColorsScreen> createState() => _ColorsScreenState();
}

class _ColorsScreenState extends State<ColorsScreen> {


    final AudioPlayerr audioPlayer=Get.find();

@override
void didChangeDependencies(){
  super.didChangeDependencies();
  final adState=Provider.of<AdState>(context,listen:false);
  adState.initialization.then((value) {
    adState.initBanner(adState.bannerColorsAddUnitId);
  });
}

  @override
  Widget build(BuildContext context) {
    final adState=Provider.of<AdState>(context,listen:false);
    return Scaffold(
      appBar: AppBar(title:  const Text("Colors"),),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  DataTable(columns: const [
                    DataColumn(label:Text("English")),
                    DataColumn(label:Text("Zulu")),
                    DataColumn(label:Text("Voice")),],
                      rows:
                         List.generate(WordsList().colorsEnglish.length, (index) =>DataRow(
                           cells:[
                             DataCell(Text(WordsList().colorsEnglish[index],style:GoogleFonts.getFont("Lato",fontStyle: FontStyle.normal))),
                             DataCell(Text(WordsList().colorsZulu[index],style:GoogleFonts.getFont("Lato",fontStyle: FontStyle.normal))),
                             DataCell(IconButton(icon: const Icon(Icons.record_voice_over_outlined),onPressed: (){
                               audioPlayer.speak(index, AudiosList().colorsAudios);
                             },))
                    ]
                        )) ),
                  const   Divider(thickness: 3.0,),

                  const  Text("Examples",style: TextStyle(fontWeight: FontWeight.bold),),
                  const ListTile(title: Text("I love the red color"),subtitle: Text("Ngiyawuthanda umbala obomvu"),),
                  const ListTile(title: Text("Buy me the black candle"),subtitle: Text("Ngithengele i-cap emnyama"),),
                  const ListTile(title: Text("That is a white car "),subtitle: Text("Lelo yimoto emhlophe"),),
                  const ListTile(title: Text("She is wearing a pink dress"),subtitle: Text("Ugqoke ingubo ephinki"),),
                  const ListTile(title: Text("They love yellow juice"),subtitle: Text("Bathanda ujusi ophuzi"),),


                ],
              ),
            ),
          ),
          if(adState.bannerAd==null)
           const SizedBox(height: 50,)

          else
            SizedBox(height: 50,   child: AdWidget(ad: adState.bannerAd!,),)
        ],
      ),
    );
  }
}
