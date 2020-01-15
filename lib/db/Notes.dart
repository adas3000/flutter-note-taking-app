

import 'package:sqflite/sqflite.dart';

const String tableNotes = "notes";
const String columnId = "_id";
const String columnTitle = "title";
const String columnDone = "done";
const String columnAddedDateText = "_added_date";


class Note{

  int id;
  String title;
  String added_date;
  bool done;

  Note({this.title,this.added_date,this.done});

}


class NotesProvider{

  Database db;

  Future open(String path) async{

    db = await openDatabase(path,version: 1,onCreate: (Database db,int version)async{
        await db.execute('''  
          $columnId integer primary key autoincrement,
          $columnTitle text not null,
          $columnDone integer not null,
          $columnAddedDateText text not null)''');
    });

  }

  Future<Note> insert(Note note)async {

    String title = note.title;
    bool done = note.done;
    String added_date = note.added_date;

    Batch batch = db.batch();
    batch.insert(tableNotes,{'$columnTitle':'$title','$columnDone':'$done','$columnAddedDateText':'$added_date'});

    await batch.commit(noResult: true);
  }






}