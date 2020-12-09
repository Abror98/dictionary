import 'dart:io';

import 'package:dictionary/model/model_dic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final databaseName = "UZENUZ.db";
  final databaseVersion = 1;
  static final tableEn = 'data_en';
  static final tableUz = 'data_uz';
  final columnEN = 'en';
  final columnUZ = 'uz';


  static final DatabaseHelper _instance = DatabaseHelper.internal();
  Database _database;
  DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  Future<Database> get database async{
    if(_database != null){
      return _database;
    }
    _database = await _initDatabase();
    return _database;
  }


  _initDatabase() async {
    var databasePath = await getDatabasesPath();
    var path = join(databasePath, databaseName);

    var exists = await databaseExists(path);

    if (!exists) {
      print('creating a new copy from asset!');

      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("assets", databaseName));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print('opening existing database');
    }

     var db  = await openDatabase(path, version: databaseVersion, readOnly: true);
     return db;
  }

  Future<List<Dictionary>>  getAllUserInfo(String table) async {
    var dbClient = await database;
    List<Map> list = await dbClient.rawQuery('select *from $table');
    List<Dictionary> user = new List();
    for(int i = 0; i < list.length; i++){
      var items = new Dictionary(
          en: list[i][columnEN],
          uz: list[i][columnUZ]
      );
      user.add(items);
    }
    print("list2 " + user.length.toString());
    print("listIndex " + user[0].en);
    return user;
  }



}

