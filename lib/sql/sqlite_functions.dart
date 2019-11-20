import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:note_app/models/note_model.dart';

class SqliteFunctions {
  final String dbName = 'harfab_noteapp.db';

  Future<Database> getDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);

    Database database = await openDatabase(
      path,
      version: 1,
      onOpen: _onOpen,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
    return database;
  }

  _onOpen(Database db) async {
    // Database is open, print its version
    print('db version ${await db.getVersion()}');
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, [desc] TEXT NOT NULL);');
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Database version is updated, alter the table
    //await db.execute("ALTER TABLE Test ADD name TEXT");
    print('_onUpgrade called.');
  }

  Future<List<Note>> getNotes() async {
    List<Note> noteList = List<Note>();
    Database db = await getDatabase();
    List<Map> list = await db.query("notes",
        columns: ["id", "title", "desc"], orderBy: "id desc");
    for (Map row in list) {
      noteList.add(Note(
        id: row["id"],
        title: row["title"],
        detail: row["desc"],
        icon: Icon(Icons.create),
      ));
    }
    return noteList;
  }

  Future<int> addNote({String title, String detail}) async {
    Database db = await getDatabase();
    int rowId = await db.insert("notes", {"title": title, "desc": detail});
    await db.close();
    return rowId;
  }

  Future<void> updateNote({int noteId, String title, String detail}) async {
    Database db = await getDatabase();
    int count = await db.update("notes", {"title": title, "desc": detail},
        where: "id = ?", whereArgs: [noteId]);
    await db.close();
  }

  Future<void> deleteNote({int noteId}) async {
    Database db = await getDatabase();
    int count = await db.delete("notes", where: "id = ?", whereArgs: [noteId]);
    await db.close();
  }
}
