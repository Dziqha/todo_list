import 'package:flutter/material.dart';
import 'package:todo_list/util/my_button.dart';

// ignore: must_be_immutable
class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onsave;
  VoidCallback oncancel;
   DialogBox({super.key, 
   required this.controller,
   required this.onsave,required this.oncancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 216, 196, 40),
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              cursorColor: Colors.black,
              controller:controller ,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "apa yang mau di list",
                labelText: "list",
              ),
            ),
            //tombol save dan cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end ,
              children: [
                //tombol save
                mybutton(text: "simpan", onPressed:onsave),

                const SizedBox(width: 8,),

                //tombol batal
                 mybutton(text: "batal", onPressed:oncancel),
              ],
            )

          ],
        ),),
    );
  }
}