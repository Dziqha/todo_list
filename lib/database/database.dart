import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Tododatabase{
  List todolist = [];
  //reference to our box
  final _mybox = Hive.box('mybox');

  

  //run this method if this is the first time ever opening the app
  void createinitialdata(){
    todolist = [];

  }
  //load the data form database
  void loaddatabase(){
    todolist = _mybox.get("TODO LIST");

  }
  //update the database
  void updatedatabase(){
    _mybox.put("TODO LIST", todolist);

  }
  
 
}



