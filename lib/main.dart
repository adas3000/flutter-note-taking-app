import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note Taking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }

}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePage createState() => _MyHomePage();

}

class _MyHomePage extends State<MyHomePage> {

  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Notes"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddNoteDialog();
          //Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPage()));
        },
        tooltip: 'add note',
        child: Icon(Icons.add),
      ),
    );
  }

  void _inputDataInDb(String note){
//      var databasesPath = await getDatabasesPath();

  }

  void _showAddNoteDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("New Note"),
            content: TextField(
              controller: textController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Title",
              ),
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Save"),
                onPressed: () {

                  String note = textController.text;

                  _inputDataInDb(note);

                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );




  }


}