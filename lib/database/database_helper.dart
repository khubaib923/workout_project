import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper{

  static const _dbName="myDatabase.db";
  static  const  _dbVersion=1;
  static const _tableName="myTable";
  static const  columnId="_id";
  static const  columnName="name";
  static const columnProperty="property";
  static const columnDate="date";

  DatabaseHelper._privateConstructor();

  static DatabaseHelper instance=DatabaseHelper._privateConstructor();

  Database? _database;

  Future<Database?>get database async{
    if(_database!=null)return _database;

    _database=await _initiateDatabase();
    return _database;

  }

  Future<Database>_initiateDatabase()async{

    Directory directory=await getApplicationDocumentsDirectory();
    String path=join(directory.path,_dbName);
    return await openDatabase(path,version: 1,onCreate: onCreated);


  }

  Future<void> onCreated(Database db,int version)async{

    await db.execute("CREATE TABLE $_tableName($columnId INTEGER PRIMARY KEY AUTOINCREMENT,$columnName TEXT,$columnProperty TEXT,$columnDate TEXT)");


  }


  Future<int>insert(Map<String,dynamic>row)async{
    Database? db=await instance.database;
    return await db!.insert(_tableName, row);

  }

  Future<List<Map<String,dynamic>>>queryAll()async{
    Database? db=await instance.database;
    return await db!.query(_tableName);
  }

}




//
// delete()async{
//   Database? db=await instance.database;
//   db!.delete(_tableName);
//
// }