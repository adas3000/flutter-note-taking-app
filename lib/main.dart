import 'package:flutter/material.dart';
import 'package:flutter_note_taking_app/add_note.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

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

class MyHomePage extends StatefulWidget{

  MyHomePage({Key key}) : super(key:key);

  @override
  _MyHomePage createState() => _MyHomePage();

}

class _MyHomePage extends State<MyHomePage>{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("My Notes"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPage()));
        },
        tooltip: 'add note',
        child: Icon(Icons.add),
      ),
    );


  }


}