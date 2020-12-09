import 'package:dictionary/db/sqlite_helper.dart';
import 'package:dictionary/model/model_dic.dart';
import 'package:dictionary/repository/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tts/tts.dart';

class DicBloc{
  final Repository repository = Repository();
  final _subjectDicEn = PublishSubject<List<Dictionary>>();
  final _subjectDicUz = PublishSubject<List<Dictionary>>();


  getWords() async {
    List<Dictionary> databaseEn = await repository.databaseItemsEn();
    print("getWords " + databaseEn.length.toString());
    _subjectDicEn.sink.add(databaseEn);
  }

  getWordsUz() async {
    List<Dictionary> databaseUz = await repository.databaseItemsUz();
    _subjectDicUz.sink.add(databaseUz);
  }



  dispose(){
    _subjectDicEn.close();
    _subjectDicUz.close();
  }

  Observable<List<Dictionary>> get allUserEn => _subjectDicEn.stream;
  Observable<List<Dictionary>> get allUserUz => _subjectDicUz.stream;

  speak(String speechText) async {
    Tts.speak(speechText);
  }
}

final bloc = DicBloc();