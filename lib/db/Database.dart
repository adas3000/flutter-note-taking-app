import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_note_taking_app/db/Notes.dart';


class DBProvider{

  final String tableNotes = "notes";
  final String columnId = "_id";
  final String columnTitle = "title";
  final String columnDone = "done";
  final String columnAddedDateText = "_added_date";

  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "NoteTakingAppDB01.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute('''  
          create table $tableNotes(
          $columnId integer primary key autoincrement,
          $columnTitle text not null,
          $columnDone integer not null,
          $columnAddedDateText text not null)''');
        });
  }


  insert(Note note) async {

    final db = await database;

    String title = note.title;
    bool done = note.done;
    String added_date = note.added_date;

    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM $tableNotes");
    int id = table.first[columnId];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into $tableNotes ($columnId,$columnTitle,$columnAddedDateText,$columnDone)"
            " VALUES (?,?,?,?)",
        [id,title,added_date,done]);
    return raw;
  }


  Future<List<Note>> get getAllNotes async{
    final db = await database;

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


}