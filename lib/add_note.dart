import 'package:flutter/material.dart';


class AddPage extends StatelessWidget{

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: Text("New Note"),
      ),
      body:TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Enter your note",
        ),
        maxLines: null,
        keyboardType: TextInputType.multiline,
      )
    );

  }

}