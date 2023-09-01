

import 'package:flutter/material.dart';
import 'package:learn_zulu/models/word_model.dart';
import 'package:learn_zulu/services/database.dart';

import 'package:translator/translator.dart';

class TranslatorProvider extends  ChangeNotifier{


  GoogleTranslator translator = GoogleTranslator();
  TextEditingController wordController=TextEditingController();

  String _englishWord="";
  String _zuluWord="";


  String get englishWord => _englishWord ;
  String get zuluWord => _zuluWord ;

String language='zu';
String languageTranslate="English";
String textToEnter="Enter English Text";
String languageTo="Zulu";
String languageTranslateTo="zu";
String languageTranslateFrom="en";
bool validate=false;

  Future<List<Word>> _words= SqliteDbProvider.db.getWords();
  Future<List<Word>> get words =>_words;

void changeLanguage(int value){
  switch(value){
    case 1:
      languageTranslate="English";
      languageTranslateFrom="en";
      textToEnter="Enter English Text";
      languageTo="Zulu";
      languageTranslateTo="zu";
      break;
    case 2:

      languageTranslate="Zulu";
      languageTranslateFrom="zu";
      textToEnter="Enter Zulu Text";
      languageTo="English";
      languageTranslateTo="en";
      break;

  }

  notifyListeners();
}
void changeLanguageTo(int value){

  switch(value){
    case 1:
      languageTo="English";
      languageTranslateTo="en";
      languageTranslate="Zulu";
      languageTranslateFrom="zu";
      textToEnter="Enter Zulu Text";
      break;
    case 2:
      languageTranslate="English";
      languageTranslateFrom="en";
      textToEnter="Enter English Text";
      languageTo="Zulu";
      languageTranslateTo="zu";


  }

  notifyListeners();
}

  void translate( ) async{

if(wordController.text.isNotEmpty){
validate=false;
      translator.translate(wordController.text,from: languageTranslateFrom ,to: languageTranslateTo).then((value) async {

    if(languageTranslateFrom=="en"){
              _englishWord=wordController.text;
              _zuluWord=value.text;
              await SqliteDbProvider.db.insertWord(Word(wordController.text, value.text));
            }else{
              _englishWord=value.text;
              _zuluWord=wordController.text;
              await SqliteDbProvider.db.insertWord(Word(value.text, wordController.text));
            }


       wordController.clear();

       notifyListeners();
         refreshWords();

      }
 );}
else{
    validate=true;
    }
     }
  void refreshWords()  {
    _words =   SqliteDbProvider.db.getWords();
    notifyListeners();
  }
void showStatus(BuildContext  context){
 
       if(_englishWord.isEmpty){
        const snackBar=  SnackBar(backgroundColor:Colors.purple,
          content:  Text("Wait a Second...."),duration:Duration(seconds:3));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
   
   notifyListeners();
}
}
