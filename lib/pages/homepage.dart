import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_list/database/database.dart';
import 'package:todo_list/util/dialog_box.dart';
import 'package:todo_list/util/to_do_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  //reference to hive box
  // ignore: unused_field
  final _mybox = Hive.box('mybox');
  Tododatabase db = Tododatabase();
  @override
  void initState() {
    // TODO: implement initState

    //if this is the first time ever opening the app, then create default data
    if(_mybox.get("TODO LIST")== null) {
      db.createinitialdata();
      }else{
        //there already exist data
        db.loaddatabase();
      }
    super.initState();
  }


  //text controler
  final _controler = TextEditingController();
 

//checkbox was tapped
void checkboxChanged(bool? value, int index){
  setState(() {
    db.todolist[index][1] = !db.todolist[index][1];
  });
  db.updatedatabase();
}
//menyimpan new task
void savenewtask(){
  setState(() {
    db.todolist.add([_controler.text,false]);
    _controler.clear();
  });
  Navigator.of(context).pop();
  db.updatedatabase();
}
//membuat dialog baru
void createnewtask(){
  showDialog(
    context: context,
     builder: (context) {
       return DialogBox(
        controller: _controler,
        onsave: savenewtask,
        oncancel: () => Navigator.of(context).pop(),

       );
     },);
}

//meghapus task
void deleteTask(int index){
  setState(() {
    db.todolist.removeAt(index);
  });
  db.updatedatabase();
}
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text("TO DO LIST"),
        elevation: 0,
        actions: [
          IconButton(onPressed:(){}, icon: Icon(Icons.search,
          color: Colors.black,))
        ],
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.menu,
        color: Colors.black,)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createnewtask,
        child: Icon(Icons.add),
        ),
      body:ListView.builder(
        itemCount:db.todolist.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskname: db.todolist[index][0], 
            taskcomplate: db.todolist[index][1],
             onChanged: (value) => checkboxChanged(value,index),
             deletefuncion: (context) => deleteTask(index) ,
             );
             
        }
      )
    );
  }
}