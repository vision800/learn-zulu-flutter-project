


import 'package:get/get.dart';


import 'package:get/state_manager.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerr extends GetxController  {

  late AudioPlayer player;
  @override
  void onInit() {

    super.onInit();
    player=AudioPlayer();
  } @override
  void dispose() {
 player.dispose();
    super.dispose();
  }


  void speak(int i,List assets) async{

    await player.setAsset(assets[i]);
    player.play();

  }


}