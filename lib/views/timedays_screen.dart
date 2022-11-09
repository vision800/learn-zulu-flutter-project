import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:learn_zulu/controlers/mobile_ads_controler.dart';

import 'package:learn_zulu/services/audio_player.dart';
import 'package:provider/provider.dart';

import '../models/audios_list_model.dart';
import '../models/words_list_model.dart';

class TimeDays extends StatefulWidget {
  const TimeDays({Key? key}) : super(key: key);

  @override
  State<TimeDays> createState() => _TimeDaysState();
}

class _TimeDaysState extends State<TimeDays> {


  final AudioPlayerr audioPlayer=Get.find();
  @override
  void initState(){
    super.initState();
    Future((){
      var width=MediaQuery.of(context).size.width;
      const  snackBar=    SnackBar(content:  Text("If you can't see everything rotate the screen"),
          duration:  Duration(seconds:1));
      if(width<340){
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    final adState=Provider.of<AdState>(context,listen:false);
    adState.initialization.then((value) {
      adState.initBanner(adState.bannerTimeAddUnitId);
    });
  }
  @override
  Widget build(BuildContext context) {
    final adState=Provider.of<AdState>(context,listen:false);
    var width=MediaQuery.of(context).size.width;
    return DefaultTabController(length: 2,child:Scaffold(
      appBar: AppBar(
        centerTitle:true,
         title:  const Text("Time&Days"),
        bottom:  const TabBar(tabs:[
          Text("Time",style: TextStyle(fontWeight:  FontWeight.bold)),
          Text("Days",style: TextStyle(fontWeight:  FontWeight.bold)),

        ]),
      ),
      body:TabBarView(children: [
      Column(
        children: [
          Expanded(
            child: SizedBox(
              width:MediaQuery.of(context).size.width,
              child: ListView(
                children: [
                  DataTable(
                      columnSpacing:width<340? 0:null,
                      columns: const [
                    DataColumn(label:Text("English")),
                    DataColumn(label:Text("Zulu")),
                    DataColumn(label:Text("Voice")),],
                    rows:List.generate(WordsList().englishDays.length, (i) =>DataRow(cells: [
                      DataCell(Text(WordsList().englishDays[i ],style:GoogleFonts.lato())),
                      DataCell(
                        Text(WordsList().zuluDays[i],style:GoogleFonts.getFont("Lato",fontStyle: FontStyle.normal)),
                      ),
                      DataCell(IconButton(icon: const Icon(Icons.record_voice_over_outlined),onPressed: (){
                        audioPlayer.speak(i, AudiosList().timeAudios);
                      },))
                    ]))),
    ]),
            ),
          ),
          if(adState.bannerAd==null)
            const SizedBox(height: 50,)

          else
            SizedBox(height: 50,   child: AdWidget(ad: adState.bannerAd!,),)
        ],
      ),


        Column(
          children: [
            Expanded(
              child: SizedBox(
                width:width,

                child: DataTable(
                    columnSpacing:width<340? 0:null,
    columns: const [
                  DataColumn(label:Text("English")),
                  DataColumn(label:Text("Zulu")),
                  DataColumn(label:Text("Voice")),],
                    rows:List.generate(WordsList().englishWeekDays.length, (i) =>DataRow(cells: [
                      DataCell(Text(WordsList().englishWeekDays[i ])),
                      DataCell(
                        Text(WordsList().zuluWeekDays[i]),
                      ),
                      DataCell(IconButton(icon: const Icon(Icons.record_voice_over_outlined),onPressed: (){
                        audioPlayer.speak(i, AudiosList().daysAudios);
                      },))
                    ]))),
              ),
            ),
            if(adState.bannerAd==null)
              const   SizedBox(height: 50,)

            else
              SizedBox(height: 50,   child: AdWidget(ad: adState.bannerAd!,),)
          ],
        ),

      ],)
    ));
  }
}
