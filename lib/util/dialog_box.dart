import 'package:flutter/material.dart';

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
      shape:RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0)),side: BorderSide(color: Colors.purple,width: 3)),
      scrollable: true,
       title: Text("NEW TASK",textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
       shadowColor: Colors.purple,
      backgroundColor: const Color.fromARGB(255, 33, 3, 85),
      content: Container(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              cursorColor: Colors.white,
              controller:controller ,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.purple)),
                focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.purple), // Border bercahaya ungu saat aktif
              ),
                enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white), // Border putih saat normal
              ),
                hintText: "apa yang mau di list",
                labelText: "list",
                labelStyle: TextStyle(color: Colors.white),
                hintStyle: TextStyle(color: Colors.white)
              ),
            ),
           SizedBox(height: 10,),
            //tombol save dan cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween ,
              children: [
                //tombol save
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                  ),
                  onPressed: onsave,
                 child: Text("Simpan")),

                const SizedBox(width: 8,),

                //tombol batal
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                  ),
                  onPressed: oncancel,
                 child: Text("Batal")),

              ],
            )

          ],
        ),),
    );
  }
}