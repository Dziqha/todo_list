import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class TodoTile extends StatelessWidget {
  final taskname;
  final taskcomplate;
  Function(bool?)? onChanged;
  Function(BuildContext)? deletefuncion;
   TodoTile({
    super.key,
    required this.taskname,
    required this.taskcomplate,
    required this.onChanged,
    required this.deletefuncion,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25,right: 25,top: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(), 
          children: [
            SlidableAction(onPressed: deletefuncion,
            icon: Icons.delete,
            backgroundColor: Colors.red.shade300,
            borderRadius: BorderRadius.circular(12),)
          ]),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color:
             Colors.yellow,
             borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              //kotak ceklis
              Checkbox(
                value: taskcomplate,
                 onChanged: onChanged,
                 activeColor: Colors.black,),
      
      
              //text pada kotak
              Text(
                taskname,
                style: TextStyle(
                  decoration:
                  taskcomplate
                  ?TextDecoration.lineThrough
                  :TextDecoration.none ),),
            ],
          ),
        ),
      ),
    );
  }
}