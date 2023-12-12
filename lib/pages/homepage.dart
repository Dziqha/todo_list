import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_list/database/database.dart';
import 'package:todo_list/profil/profil.dart';
import 'package:todo_list/util/dialog_box.dart';
import 'package:todo_list/util/to_do_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  //reference to hive box
  // ignore: unused_field
   final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  
  late File dataFile;
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
    initFile();
  }
  Future<void> initFile() async {
    dataFile = await getLocalFile();
    final data = await loadData();
    nameController.text = data['name'];
    emailController.text = data['email'];
  }

  Future<File> getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    return File('$path/data.json');
  }

  Future<void> saveData(String name, String email) async {
    final jsonData = {
      'name': name,
      'email': email,
    };
    await dataFile.writeAsString(json.encode(jsonData));
  }

  Future<Map<String, dynamic>> loadData() async {
    try {
      final content = await dataFile.readAsString();
      return json.decode(content);
    } catch (e) {
      return {
        'name': '',
        'email': '',
      };
    }
  }

  void onSaveData() {
    final name = nameController.text;
    final email = emailController.text;
    saveData(name, email);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Data saved successfully!'),
    ));
    Navigator.of(context).pop();
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
void buatprofile(){
  showDialog(
    context: context,
     builder: (context) {
       return profile(
        controller: nameController,
        onsave: onSaveData,
         oncancel: () => Navigator.of(context).pop());
     },);
}


Future<String> getNameFromProfileJson() async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final file = File('$path/data.json'); // Replace with the actual path to your profile JSON file
    final content = await file.readAsString();
    final jsonData = json.decode(content);
    final name = jsonData['name'];

    return name;
  } catch (e) {
    // Handle exceptions, e.g., if the file doesn't exist or JSON parsing fails.
    return "Unknown"; // Provide a default value or error handling strategy.
  }
}

//meghapus task
void deleteTask(int index){
  setState(() {
    db.todolist.removeAt(index);
  });
  db.updatedatabase();
}

  String name = "";

  Future<void> loadName() async {
    final newName = await getNameFromProfileJson();
    setState(() {
      name = newName;
    });
  }
  
  
       @override
        Widget build(BuildContext context) {
          loadName();
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 33, 3, 85),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.purple,
            onPressed: (){createnewtask();},
            tooltip: 'increment',
            child: Icon(Icons.add),
            ),
          
            body:
          Stack(
        children: <Widget>[
          Center(
            child: Container(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 120),
                itemCount: db.todolist.length,
                itemBuilder: (context, index) {
                  return TodoTile(
                    taskname: db.todolist[index][0],
                    taskcomplate: db.todolist[index][1],
                    onChanged: (value) => checkboxChanged(value, index),
                    deletefuncion: (context) => deleteTask(index),
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: 70, // Jarak dari atas
            left: 50, // Jarak dari kiri
            child: Text('🖐️ Hallo $name',
            style: TextStyle(fontSize: 20,
            color: Colors.white),)
          ),
          Positioned(
            top: 105, // Jarak dari atas
            left: 53, // Jarak dari kiri
            child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Have a Wonderful Day',
                    textStyle: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                    speed: const Duration(seconds: 1),
                  ),
                ],
                
                totalRepeatCount: 4,
                pause: const Duration(seconds: 1),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              )
          ),
        
          Positioned(
            top: 60, // Jarak dari atas
            right: 50, // Jarak dari kanan
            child: IconButton(
              icon: Icon(Icons.account_circle,size: 50,color: Colors.white,),
              onPressed: () {
              buatprofile(); // Ganti ProfilePage() dengan halaman profil yang sesuai
              },
            ),
          ),
        ],
      ) 
          );
      }
}