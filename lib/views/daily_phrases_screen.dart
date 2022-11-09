import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:learn_zulu/controlers/mobile_ads_controler.dart';
import 'package:provider/provider.dart';

import '../models/words_list_model.dart';


class DailyPhrases extends StatefulWidget {
  const DailyPhrases({Key? key}) : super(key: key);

  @override
  State<DailyPhrases> createState() => _DailyPhrasesState();
}

class _DailyPhrasesState extends State<DailyPhrases> {


    @override
    void didChangeDependencies(){
      super.didChangeDependencies();
      final adState=Provider.of<AdState>(context,listen:false);
      adState.initialization.then((value) {
        adState.initBanner(adState.bannerDailyPhrasesAddUnitId);
      });
    }

  @override
  Widget build(BuildContext context) {
    final adState=Provider.of<AdState>(context,listen:false);
    return Scaffold(
      appBar: AppBar(title: const Text("DailyPhrases"),),
     body: Column(
        children: [
         Expanded(
           child: Scrollbar(
             child: ListView.builder(itemCount: WordsList().dailyPhrases.length,itemBuilder: (context,i)=>Column(
               children: [
                 ListTile(
                   leading: Text("${i+1}"),
                   title: Text(WordsList().dailyPhrases[i],style:GoogleFonts.getFont("Lato",fontStyle: FontStyle.normal)),
                   subtitle: Text(WordsList().zuluList[i],style:GoogleFonts.getFont("Lato",fontStyle: FontStyle.normal)),
                 ),

               ],
             )),
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
