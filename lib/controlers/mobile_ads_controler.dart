import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class  AdState extends ChangeNotifier {
 late Future<InitializationStatus> initialization;
 AdState(this.initialization);
 //String bannerAddUnitId="ca-app-pub-3940256099942544/6300978111";
 String bannerFamilyAddUnitId="ca-app-pub-7455041506970120/6645155315";
 String bannerColorsAddUnitId="ca-app-pub-7455041506970120/9801252952";
 String bannerBodyPartsAddUnitId="ca-app-pub-7455041506970120/7219870384";
 String bannerDailyPhrasesAddUnitId="ca-app-pub-7455041506970120/3228654480";
 String bannerDictionaryAddUnitId="ca-app-pub-7455041506970120/1149286051";
 String bannerFoodAddUnitId="ca-app-pub-7455041506970120/1573039457";
 String bannerGreetingsAddUnitId="ca-app-pub-7455041506970120/7208509519";
 String bannerNounsAddUnitId="ca-app-pub-7455041506970120/6628294708";
 String bannerPronounsAddUnitId="ca-app-pub-7455041506970120/5123641343";
 String bannerConjuctionsAddUnitId="ca-app-pub-7455041506970120/3967021082";
 String bannerNumbersAddUnitId="ca-app-pub-7455041506970120/6784756115";
 String bannerTimeAddUnitId="ca-app-pub-7455041506970120/3663768755";
 String bannerTranslatorAddUnitId="ca-app-pub-7455041506970120/6707351602";



 BannerAd? bannerAd;


  BannerAdListener adListener= const BannerAdListener(



  );
  void initBanner(String bannerId){
   bannerAd=BannerAd(
    adUnitId:  bannerId,
    size: AdSize.banner,
    request: const AdRequest(),
    listener: adListener,
   )..load();

   notifyListeners();
  }
}