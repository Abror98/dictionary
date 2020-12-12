import 'package:dictionary/db/sqlite_helper.dart';
import 'package:dictionary/model/model_dic.dart';
import 'package:dictionary/repository/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tts/tts.dart';

class DicBloc {
  final Repository repository = Repository();
  final _subjectDic = PublishSubject<List<Dictionary>>();

  Observable<List<Dictionary>> get allUser => _subjectDic.stream;

  getWord(bool isEng) async {
    if (isEng) {
      List<Dictionary> databaseEn = await repository.databaseItemsEn();
      _subjectDic.sink.add(databaseEn);
    } else {
      List<Dictionary> databaseUz = await repository.databaseItemsUz();
      _subjectDic.sink.add(databaseUz);
    }
  }

  dispose() {
    _subjectDic.close();
  }

  speak(String speechText) async {
    Tts.speak(speechText);
  }
}

final bloc = DicBloc();
