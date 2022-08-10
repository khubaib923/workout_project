import 'package:flutter/foundation.dart';
import 'package:workout_project/database/database_helper.dart';

class WorkProvider with ChangeNotifier{
  late Future<List<Map<String,dynamic>>> _cart;

  Future<List<Map<String,dynamic>>> get cart=>_cart;

  Future<List<Map<String,dynamic>>> getData() async{

    _cart =  DatabaseHelper.instance.queryAll();
    return _cart;



  }
  notifyListeners();


}