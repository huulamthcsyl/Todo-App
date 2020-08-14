import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/services/database.dart';

class Edit extends StatefulWidget {

  Todo work;
  Edit(this.work);

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {

  final _title = TextEditingController();
  final _description = TextEditingController();
  final _keyForm = GlobalKey<FormState>();
  var _isLoading = false;

  void Process() async {
    if(_keyForm.currentState.validate()){
      setState(() {
        _isLoading = true;
      });
      if(widget.work.id == null){
        Map<String, dynamic> data = {
          'id': randomAlphaNumeric(16),
          'title': _title.text,
          'description': _description.text,
          'isFavourite': false,
          'isDone': false,
          'timestamp': FieldValue.serverTimestamp()
        };
        await addNewWork(data).then((value){
          setState(() {
            _isLoading = false;
          });
          Navigator.pop(context);
        });
      }
    }
  }

  @override
  void initState() {
    _title.text = widget.work.title;
    _description.text = widget.work.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black87),
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              Process();
            },
          ),
        ],
      ),
      body: _isLoading ? Container(child: Center(child: CircularProgressIndicator(),),) : 
      Form(
        key: _keyForm,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Title',
                    border: InputBorder.none
                  ),
                  controller: _title,
                  validator: (value) => value.trim().isEmpty ? 'Please enter title' : null,
                ),
                SizedBox(height: 8,),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Description',
                    border: InputBorder.none
                  ),
                  controller: _description,
                  maxLines: 15,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}