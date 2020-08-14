import 'package:flutter/material.dart';
import 'package:todo_app/services/database.dart';
import 'package:todo_app/widgets/todoWg.dart';

class Favourite extends StatefulWidget {
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {

  Stream stream;

  @override
  void initState() {
    getFavouriteWork().then((value){
      setState(() {
        stream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          return snapshot.data == null ? Container() : 
          ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              return TodoWg(
                id: snapshot.data.documents[index].data['id'],
                title: snapshot.data.documents[index].data['title'],
                description: snapshot.data.documents[index].data['description'],
                isFavourite: snapshot.data.documents[index].data['isFavourite'],
                isDone: snapshot.data.documents[index].data['isDone'],
              );
            },
          );
        },
      ),
    );
  }
}