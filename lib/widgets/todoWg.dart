import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/services/database.dart';
import 'package:todo_app/views/edit.dart';

class TodoWg extends StatefulWidget {

  final String title, id, description;
  final bool isFavourite, isDone;

  TodoWg({@required this.id, @required this.title, @required this.description, @required this.isFavourite, @required this.isDone});
  
  @override
  _TodoWgState createState() => _TodoWgState();
}

class _TodoWgState extends State<TodoWg> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.2,
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8))
          ),
          child: GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Edit(Todo(id: widget.id, title: widget.title, description: widget.description)),)),
            child: Row(
              children: [
                Text(widget.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),),
                Spacer(),
                widget.isFavourite ? 
                GestureDetector(
                  onTap: () => changeFavourite(widget.id, false),
                  child: Icon(Icons.star, color: Colors.yellow, size: 30,)
                ) : 
                GestureDetector(
                  onTap: () => changeFavourite(widget.id, true),
                  child: Icon(Icons.star_border, size: 30,)
                )
              ],
            ),
          ),
        ),
        secondaryActions: [
          if(!widget.isDone) IconSlideAction(
            caption: 'Done',
            color: Colors.green,
            icon: Icons.done,
            onTap: () {
              showDialog(
                context: context, 
                builder: (context) {
                  return AlertDialog(
                    title: Text('Confirm'),
                    content: Text("Do you done it?"),
                    actions: [
                      CupertinoButton(
                        child: Text('OK'), 
                        onPressed: () => Navigator.pop(context, true),
                      ),
                      CupertinoButton(
                        child: Text('Cancel'), 
                        onPressed: () => Navigator.pop(context, false),
                      ),
                    ],
                  );
                },
              ).then((value){
                if(value) doneWork(widget.id);
              });
            },
          ),
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              showDialog(
                context: context, 
                builder: (context) {
                  return AlertDialog(
                    title: Text('Confirm'),
                    content: Text("Do you want to delete it?"),
                    actions: [
                      CupertinoButton(
                        child: Text('OK'), 
                        onPressed: () => Navigator.pop(context, true),
                      ),
                      CupertinoButton(
                        child: Text('Cancel'), 
                        onPressed: () => Navigator.pop(context, false),
                      ),
                    ],
                  );
                },
              ).then((value){
                if(value) removeWork(widget.id);
              });
            },
          )
        ],
      )
    );
  }
}