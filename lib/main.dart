import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_list/pages/lottie/lottieku.dart';




void main()async{
  //init the hive
  await Hive.initFlutter();
  //open a box
  // ignore: unused_local_variable
  var box = await Hive.openBox('mybox');
  
  runApp(myapk());
}


class myapk extends StatelessWidget {
  const myapk({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: animasi(),
      theme: ThemeData(primarySwatch: Colors.deepPurple),
    );
  }
}