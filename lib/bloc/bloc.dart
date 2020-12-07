import 'package:dictionary/db/sqlite_helper.dart';
import 'package:dictionary/model/model_dic.dart';
import 'package:dictionary/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class DicBloc{
  final Repository repository = Repository();
  final _subjectDic = PublishSubject<List<Dictionary>>();

   getWords() async {
    List<Dictionary> database = await repository.databaseItems();
    print("getWords " + database.length.toString());
    _subjectDic.sink.add(database);
  }


  dispose(){
    _subjectDic.close();
  }

  Observable<List<Dictionary>> get allUserPed => _subjectDic.stream;
}

final bloc = DicBloc();