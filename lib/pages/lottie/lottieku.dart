import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_list/google_font/aksesoris.dart';
import 'package:todo_list/pages/homepage.dart';
 class animasi extends StatefulWidget {
  const animasi({super.key});

  @override
  State<animasi> createState() => _animasiState();
}

class _animasiState extends State<animasi> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
        backgroundColor: Colors.deepPurple,
        body: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Text("WELCOME BACK !",style: textTextStyle.copyWith(
                  fontSize: 30,fontWeight: bold,
                ),),
                SizedBox(height: 5,),
                Text("to MY TO-DO LIST !",style: textTextStyle.copyWith(
                  fontSize: 15,fontWeight: bold,
                ),),
                Lottie.asset(
                  'assets/animation/animation_lo8mvzt9.json',
                  width: 400,
                  height: 400,
                  fit: BoxFit.fill),
                  Text("Please press the enter button to enter the application",
                  style: textTextStyle.copyWith(fontSize: 10,fontWeight: bold),),
                  
                   
                  SizedBox(height: 50,),
                  Container(
               child: AnimatedButton(
                text: "Submit",
                color: Colors.blue,
                pressEvent: (){
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.topSlide,
                    showCloseIcon: true,
                    title: "Success",
                    desc: "Silahkan pencet Tombol OK untuk masuk",
                    btnOkOnPress: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context){
                          return homepage();
                        })
                      );
                    },
                    ).show();
                }),
             ),
             SizedBox(height: 15,),
             Text(
              "Copy right © 2023 Dziq_ha",
              style: textTextStyle.copyWith(fontSize: 12,fontWeight: bold),),
              ],
              
              ),
              ),),
              )
    );
  }
}

