
import 'package:dictionary/db/sqlite_helper.dart';
import 'package:dictionary/model/model_dic.dart';

class Repository{
  DatabaseHelper databaseHelper = DatabaseHelper();

  Future<List<Dictionary>> databaseItems() => databaseHelper.getAllUserInfo(DatabaseHelper.tableEn);
}