import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_list/database/database.dart';

class TodoTile extends StatefulWidget {
  final String taskname;
  final bool taskcomplate;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deletefuncion;

  TodoTile({
    super.key,
    required this.taskname,
    required this.taskcomplate,
    required this.onChanged,
    required this.deletefuncion,
  });

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  TextEditingController _textEditingController = TextEditingController();
  bool isEditing = false;
  Tododatabase db = Tododatabase();

  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.taskname;
  }

  void saveedittask() {
    setState(() {
      db.todolist.add([_textEditingController.text, false]);
    });
    db.updatedatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25, top: 30),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: widget.deletefuncion,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: widget.taskcomplate,
                        onChanged: widget.onChanged,
                        activeColor: Colors.black,
                      ),
                      Expanded(
                        child: Text(
                          isEditing ? _textEditingController.text : widget.taskname,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            decoration: widget.taskcomplate
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            decorationColor: Colors.black,
                          ),
                        ),
                      ),
                     
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
