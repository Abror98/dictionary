
import 'package:dictionary/db/sqlite_helper.dart';
import 'package:dictionary/model/model_dic.dart';

class Repository{
  DatabaseHelper databaseHelper = DatabaseHelper();

  Future<List<Dictionary>> databaseItemsEn() => databaseHelper.getAllUserInfo(DatabaseHelper.tableEn);
  Future<List<Dictionary>> databaseItemsUz() => databaseHelper.getAllUserInfo(DatabaseHelper.tableUz);
}