class Word{
  String englishWord="";
  String zuluWord="";
  Word( this.englishWord,  this.zuluWord);
  factory Word.fromMap(Map<String,dynamic> data){
    return Word(data['englishWord'],data['zuluWord']);
  }

  Map<String,dynamic> toMap()=>{
    'englishWord':englishWord,
    'zuluWord':zuluWord,

  };
}