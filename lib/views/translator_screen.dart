import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:learn_zulu/controlers/theme_controler.dart';


import 'package:learn_zulu/controlers/trasnlator_provider_controler.dart';
import 'package:learn_zulu/models/word_model.dart';
import 'package:learn_zulu/services/database.dart';
import 'package:share_plus/share_plus.dart';
import 'package:provider/provider.dart';

import '../controlers/mobile_ads_controler.dart';
class TranslatorScreen extends StatefulWidget {
   const TranslatorScreen({Key? key}) : super(key: key);

  @override
  State<TranslatorScreen> createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {
  @override
  void initState(){
    super.initState();
    Future((){
      const snackBar=  SnackBar(backgroundColor:Colors.purple,
          content:  Text("You must be connected to mobile or wifi connection to translate words!!"),duration:Duration(seconds:2));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    final adState=Provider.of<AdState>(context,listen:false);
    adState.initialization.then((value) {
      adState.initBanner(adState.bannerTranslatorAddUnitId);
    });
  }
   @override
  Widget build(BuildContext context) {
var translator=Provider.of<TranslatorProvider>(context, listen: true);
var provider=Provider.of<ThemeChanger>(context);
final adState=Provider.of<AdState>(context,listen:false);
    return DefaultTabController(
      length: 2,
      child: Scaffold(


          appBar: AppBar(centerTitle: true,title:const Text("Translator"),bottom:const TabBar(tabs:  [
            Tab(child: Text("Translate"),),
            Tab(child: Text("Translated"),),
          ])),
          body: TabBarView(
            children: [

                Column(children:[
                  Expanded(
                    child: ListView(

                      children: [

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(

                              children:[

                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:MainAxisAlignment.spaceAround,
                                      children: [
                                        Chip(
                                          onDeleted:(){},
                                          padding:  const EdgeInsets.symmetric(vertical:-5 ),
                                          deleteIcon:  PopupMenuButton(
                                            onSelected:translator.changeLanguage ,
                                            icon: const Icon(Icons.arrow_drop_down),
                                            itemBuilder: (context)=> const  [
                                              PopupMenuItem(value:1,child: Text("English"), ),
                                              PopupMenuItem(value:2,child: Text("Zulu"), ),

                                            ],

                                          ),
                                          label:

                                          Text(translator.languageTranslate ),



                                        ),
                                        Expanded(
                                          child: Column(
                                            children: const[
                                              Icon(Icons.arrow_forward,size: 20.0,),
                                              Icon(Icons.arrow_back,size: 20.0,),
                                            ],
                                          ),
                                        ),
                                        Chip(
                                          padding: const  EdgeInsets.symmetric(vertical:-5 ),
                                          onDeleted:(){},

                                          deleteIcon: PopupMenuButton(
                                            onSelected:translator.changeLanguageTo,
                                            icon: const Icon(Icons.arrow_drop_down),
                                            itemBuilder: (context)=>  const [
                                              PopupMenuItem(value:1,child: Text("English") ),
                                              PopupMenuItem(value:2,child: Text("Zulu"), ),


                                            ],

                                          ),
                                          label:
                                          Text(translator.languageTo ),


                                        ),
                                      ],
                                    ),
                                    TextField(maxLines: 5,decoration:  InputDecoration(hintText: translator.textToEnter,
                                        border: const OutlineInputBorder(),
                                        errorText:translator.validate?"Value cant be empty":null
                                    ),

                                      controller: translator.wordController,

                                    ),
                                    const SizedBox(height:5.0),
                                    //button
                                    GestureDetector(

                                      child: Card(
                                        color: provider.getTheme==provider.dark?Colors.black12:Colors.deepPurple,

                                        child:   Center(child: TextButton(child: const Text("Translate",style: TextStyle(color: Colors.white),),onPressed: (){
                                          Provider.of<TranslatorProvider>(context, listen: false).translate();
                                          FocusScopeNode currentFocus=FocusScope.of(context);
                                          if(!currentFocus.hasPrimaryFocus){
                                            currentFocus.unfocus();
                                          }

                                        },),),

                                      ),
                                      onTap: (){
                                        Provider.of<TranslatorProvider>(context, listen: false).translate();
                                        FocusScopeNode currentFocus=FocusScope.of(context);
                                        if(!currentFocus.hasPrimaryFocus){
                                          currentFocus.unfocus();
                                        }

                                      },
                                    ),
                                  ],
                                ),
                                Card(
                                    elevation:8,

                                    child:Padding(padding:const EdgeInsets.all(5.0) ,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [



                                          Row(
                                            children: [
                                              const Text( "English",
                                                  style:TextStyle(fontSize:20.0,fontWeight:FontWeight.bold)),
                                              const Expanded(child: Text("")),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [

                                                  IconButton(icon:const Icon(Icons.copy_outlined),onPressed: (){
                                                    FlutterClipboard.copy( translator.englishWord ).then((value){
                                                      return  Get.snackbar("Words", "Copied Succesfully",snackPosition: SnackPosition.BOTTOM);
                                                    });
                                                  },),
                                                  IconButton(icon:const Icon(Icons.share),onPressed: ()async {
                                                    final box=context.findRenderObject() as RenderBox?;
                                                    await Share.share(translator.englishWord,
                                                        sharePositionOrigin:box!.localToGlobal(Offset.zero) & box.size);

                                                  },),
                                                ],
                                              )
                                            ],
                                          ),

                                          Text( translator.englishWord ,textAlign: TextAlign.left,
                                              style:GoogleFonts.getFont("Lato",fontSize: 17.0)),


                                          const SizedBox(height:10.0),
                                          const Divider(),
                                          const SizedBox(height:10.0),
                                          Row(children: [
                                            const  Text( "Zulu",

                                                style:    TextStyle(fontSize:20.0,
                                                    fontWeight:FontWeight.bold)),
                                            const Expanded(child: Text("")),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [

                                                IconButton(icon: const   Icon(Icons.copy_outlined),onPressed: (){
                                                  FlutterClipboard.copy( translator.zuluWord ).then((value){
                                                    return  Get.snackbar("Words", "Copied Succesfully",snackPosition: SnackPosition.BOTTOM);
                                                  }) ;
                                                },),
                                                IconButton(icon:const Icon(Icons.share),onPressed: ()async {
                                                  final box=context.findRenderObject() as RenderBox?;
                                                  await Share.share(translator.zuluWord,
                                                      sharePositionOrigin:box!.localToGlobal(Offset.zero) & box.size);

                                                },),
                                              ],
                                            )

                                          ]),
                                          const SizedBox(height:5.0),

                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 8.0),
                                            child: Text( translator.zuluWord ,textAlign: TextAlign.left,
                                                style:GoogleFonts.getFont("Lato",fontSize: 17.0)),
                                          ),

                                        ],
                                      ),)
                                ),



                              ]),
                        )
                      ],
                    ),
                  ),
                  if(adState.bannerAd==null)
                    const SizedBox(height: 50,)

                  else
                    SizedBox(height: 50,  child: AdWidget(ad: adState.bannerAd!,),)
                ]),




              //futurebuilder
               Column(children:[
                 Expanded(
                   child:FutureBuilder<List<Word>>(future:translator.words,
                     builder: (BuildContext context,AsyncSnapshot<List<Word>> snapshot) {
                       if(!snapshot.hasData) {
                         return const Center(child: Text("No data....."),);

                       }
                       else{
                         return   ListView.builder(itemBuilder: (context,i){
                           Word word=snapshot.data![i];

                           return ListTile(
                               title: Text(word.englishWord),
                               subtitle: Text(word.zuluWord),
                               trailing: IconButton(icon: const Icon(Icons.delete),onPressed:() async{
                                 await SqliteDbProvider.db.deleteWord(word);
                                 translator.refreshWords();
                               })
                           );
                         },
                             itemCount: snapshot.data!.length)

                         ;
                       }

                     }),),
                 if(adState.bannerAd==null)
                   const SizedBox(height: 50,)

                 else
                   SizedBox(height: 50,  child: AdWidget(ad: adState.bannerAd!,),)
               ])

            ],
          )
      ),
    );
  }
}
