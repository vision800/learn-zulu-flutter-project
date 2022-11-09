import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:learn_zulu/controlers/mobile_ads_controler.dart';
import 'package:learn_zulu/models/words_list_model.dart';

import 'package:provider/provider.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({Key? key}) : super(key: key);

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  String foundWord="";

  TextEditingController wordControler=TextEditingController();
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    final adState=Provider.of<AdState>(context,listen:false);
    adState.initialization.then((value) {
      adState.initBanner(adState.bannerDictionaryAddUnitId);
    });
  }

  @override
  Widget build(BuildContext context) {

    final adState=Provider.of<AdState>(context,listen:false);
    return Scaffold(

      appBar: AppBar(centerTitle: true,title:const Text("Verbs"),actions: [
          IconButton(onPressed: (){

showSearch(context: context,delegate:MySearchDelegate());
        },icon: const  Icon(Icons.search),)
      ],),
      body: Column(
        children: [
          Expanded(
            child: Scrollbar(
              child:ListView.builder(itemCount: WordsList().englishWords.length,itemBuilder: (context,i)=>
                ListTile(
                  leading:Text("${i+1}"),
                  title:Text( WordsList().englishWords[i]),
                  subtitle: Text(WordsList().zuluWords[i]),
                )),
            )
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
class MySearchDelegate extends SearchDelegate{


  @override
  List<Widget>? buildActions(BuildContext context) {
  return [
    IconButton(onPressed:(){
      if(query.isEmpty){
        close(context,null);
      }
    query='';
  },icon: const Icon(Icons.clear))
  ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
   return IconButton(onPressed:(){
      close(context,null);
    },icon:const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery=[];
    List<String> matchQueryZulu=[];
    for(int i=0;i<WordsList().englishWords.length;i++){
      if(WordsList().englishWords[i].toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(WordsList().englishWords[i]);
        matchQueryZulu.add(WordsList().zuluWords[i]);

      }
    }
    return ListView.builder(itemCount:matchQuery.length,itemBuilder:(context,i){
      var result=matchQuery[i];
      var resultZulu=matchQueryZulu[i];
      return ListTile(
        title:Text(result),
        subtitle: Text(resultZulu),

      );
    });
  }
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery=[];
    List<String> matchQueryZulu=[];
    for(int i=0;i<WordsList().englishWords.length;i++){
      if(WordsList().englishWords[i].toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(WordsList().englishWords[i]);
        matchQueryZulu.add(WordsList().zuluWords[i]);

      }
    }
    return ListView.builder(itemCount:matchQuery.length,itemBuilder:(context,i){
      var result=matchQuery[i];
      var resultZulu=matchQueryZulu[i];
      return ListTile(
          title:Text(result),
        subtitle: Text(resultZulu),
      );
    });
  }

}
