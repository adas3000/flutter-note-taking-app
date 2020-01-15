import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const String tableNotes = "notes";
const String columnId = "_id";
const String columnTitle = "title";
const String columnDone = "done";
const String columnAddedDateText = "_added_date";


class Note {

  int id;
  String title;
  String added_date;
  bool done;

  Note({this.id, this.title, this.added_date, this.done});


  factory Note.fromMap(Map<String, dynamic>json) =>
      new Note(
        id: json[columnId],
        title: json[columnTitle],
        added_date: json[columnAddedDateText],
        done: json[columnDone] == 1,
      );

  Map<String, dynamic> toMap() =>
      {
        columnId: id,
        columnTitle: title,
        columnDone: done,
        columnAddedDateText: added_date
      };


}


class NotesProvider {

  Database db;

  Future open() async {
    Directory documentDir = await getApplicationDocumentsDirectory();

    String path = documentDir.path + "/flutter_note_taking_appDB01.db";

    db = await openDatabase(
        path, version: 1, onCreate: (Database db, int version) async {
      await db.execute('''  
          create table $tableNotes(
          $columnId integer primary key autoincrement,
          $columnTitle text not null,
          $columnDone integer not null,
          $columnAddedDateText text not null)''');
    });
  }

  Future<Note> insert(Note note) async {
    String title = note.title;
    bool done = note.done;
    String added_date = note.added_date;

    Batch batch = db.batch();
    batch.insert(tableNotes, {
      '$columnTitle': '$title',
      '$columnDone': '$done',
      '$columnAddedDateText': '$added_date'
    });

    await batch.commit(noResult: true);
  }

  Future<int> delete(int id) async {
    return await db.delete(tableNotes, where: '$columnId = ?', whereArgs: [id]);
  }

  getAllNotes() async {

    var res = await db.query(tableNotes);

    List<Note> list = res.isNotEmpty
        ? res.toList().map((c) => Note.fromMap(c)) : [];
    return list;
  }

  Future<List<Note>> get data async{
    List<Note> list = List();

    Note f_n = Note();
    f_n.id=1;
    f_n.done=true;
    f_n.title="someTitle";
    f_n.added_date="yesterday";
    list.add(f_n);

    return list;
  }

  Future close() async => db.close();


}