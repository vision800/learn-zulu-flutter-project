import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:learn_zulu/controlers/mobile_ads_controler.dart';
import 'package:provider/provider.dart';
import '../models/words_list_model.dart';
class GreetingScreen extends StatefulWidget {
  const GreetingScreen({Key? key}) : super(key: key);

  @override
  State<GreetingScreen> createState() => _GreetingScreenState();
}

class _GreetingScreenState extends State<GreetingScreen> {

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    final adState=Provider.of<AdState>(context,listen:false);
    adState.initialization.then((value) {
      adState.initBanner(adState.bannerGreetingsAddUnitId);
    });
  }

  @override
  Widget build(BuildContext context) {

     final adState=Provider.of<AdState>(context,listen:false);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle:true,
          title:const Text("Greetings"),
          bottom:const TabBar(tabs: [
            Tab(child: Text("Greeting" ,),) ,
            Tab(child: Text("Response" ),) ,
          ]),

        ),
          body:TabBarView(children: [
            Column(
              children: [
                Expanded(
                  child: ListView.builder(itemCount:WordsList().greetings.length,itemBuilder: (context,i)=>Column(
                    children: [
                      ListTile(
                        leading: Text("${i+1}"),
                        title: Text(WordsList().greetings[i],style:GoogleFonts.getFont("Lato")),
                        subtitle: Text(WordsList().greetingsZulu[i],style:GoogleFonts.getFont("Lato",fontStyle: FontStyle.normal)),
                      ),

                    ],
                  )),
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
                  child: ListView.builder(itemCount:WordsList().respones.length,itemBuilder: (context,i)=>Column(
                    children: [
                      ListTile(
                        leading: Text("${i+1}"),
                        title: Text(WordsList().respones[i]),
                        subtitle: Text(WordsList().responesZulu[i]),
                      ),

                    ],
                  )),
                ),
                if(adState.bannerAd==null)
                 const SizedBox(height: 50,)

                else
                  SizedBox(height: 50,   child: AdWidget(ad: adState.bannerAd!,),)
              ],
            ),
          ],)
          ),
    );
  }
}
