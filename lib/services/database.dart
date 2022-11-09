import 'dart:io';

import 'package:learn_zulu/models/word_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SqliteDbProvider{
String databaseName="Word.db";
String databaseTable="Word";
int databaseVersion=1;

String englishWord="englishWord";
String zuluWord="zuluWord";
SqliteDbProvider._();

static final SqliteDbProvider db =SqliteDbProvider._();

  Database? _database;

Future<Database> get database async{
  if(_database !=null)return _database!;

  _database= await initDb();
  return _database!;
}

    initDb() async{
Directory directory= await getApplicationDocumentsDirectory();
 String path= join(directory.path,databaseName);

return openDatabase(path,version: 1,
    onCreate: (Database db,int version) async{
await db.execute( 'CREATE TABLE $databaseTable($englishWord TEXT PRIMARY KEY,$zuluWord TEXT)');
});
  }
Future<List<Word>> getWords() async{
  final db=await database;

  List<Map<String,dynamic>> maps=await db.query(databaseTable);
  return List.generate(maps.length, (index) =>
      Word( maps[index]['englishWord'],maps[index]['zuluWord']));
}
Future<List<Map<String,dynamic>>> getAllWords() async{
  final db=await database;


  return db.query(databaseTable);
}

Future<void> insertWord(Word word) async{
  final db=await database;
  await db.insert(databaseTable, word.toMap(),conflictAlgorithm:ConflictAlgorithm.replace,);

}
Future<void> deleteWord(Word word) async{
  final db=await database;
  await db.delete(databaseTable,where: 'englishWord = ?',whereArgs: [word.englishWord]);

}


}
