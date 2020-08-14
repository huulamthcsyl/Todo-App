import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/views/done.dart';
import 'package:todo_app/views/edit.dart';
import 'package:todo_app/views/favourite.dart';
import 'package:todo_app/views/work.dart';
import 'package:todo_app/models/todo.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final _page = [Work(), Favourite(), Done()];
  final _title = ['Work', 'Favourite', 'Done'];

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: Text(_title[_currentPage]),
        elevation: 0.0,
        actions: [
          IconButton(
            tooltip: 'Add work',
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Edit(Todo())));
            },
          )
        ],
      ),
      body: _page[_currentPage],
      backgroundColor: Colors.blue[600],
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.flip,
        backgroundColor: Colors.purple[300],
        items: [
          TabItem(icon: Icons.assignment, title: 'Work'),
          TabItem(icon: Icons.star_border, title: 'Favourite'),
          TabItem(icon: Icons.done, title: 'Done'),
        ],
        onTap: (index) {
          setState(() {
            _currentPage = index;
          });
        },
      ),
    );
  }
}