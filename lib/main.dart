import 'package:flutter/material.dart';
import 'package:flutter_note_taking_app/db/Database.dart';
import 'package:flutter_note_taking_app/db/Notes.dart';
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
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Notes"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddNoteDialog();
        },
        tooltip: 'add note',
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List<Note>>(
        future: DBProvider.db.getAllNotes,
        builder: (BuildContext context, AsyncSnapshot<List<Note>>snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Note note = snapshot.data[index];
                return ListTile(
                  title: Text(note.title),
                  trailing: Checkbox(
                    onChanged: (bool value) {
                      checked = value;
                      setState(() {});
                    },
                    value: checked,
                  ),
                );
              },
            );
          }
          else return Center(child:CircularProgressIndicator());
        },
      ),
    );
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

                  Note _note = Note();
                  _note.done = false;
                  _note.added_date = "yesterday";
                  _note.title = "Buy Milk";

                  DBProvider.db.insert(_note);

                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
  }


}