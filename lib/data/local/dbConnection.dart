import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBConnection {
  DBConnection._();

  static DBConnection getInstance = DBConnection._();

  static const String TABLE_NOTE = "note";
  static const String COLUMN_TABLE_SNO = "sno";
  static const String COLUMN_TABLE_TITLE = "title";
  static const String COLUMN_TABLE_CATEGORY = "category";
  static const String COLUMN_TABLE_DATE = "date";
  static const String COLUMN_TABLE_TIME = "time";
  static const String COLUMN_TABLE_DESCRIPTION = "description";

  Database? myDB;

  Future<Database> getDB() async => myDB ??= await openDB();

  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, "note.db");

    return await openDatabase(
      dbPath,
      onCreate: (db, version) {
        db.execute("create table $TABLE_NOTE ("
          "$COLUMN_TABLE_SNO integer primary key autoincrement"
          "$COLUMN_TABLE_TITLE text not null"
          "$COLUMN_TABLE_CATEGORY integer not null"
          "$COLUMN_TABLE_DATE text not null"
          "$COLUMN_TABLE_TIME text not null"
          "$COLUMN_TABLE_DESCRIPTION text");
      },
      version: 5
    );
  }

  //insertion
  Future<bool> addNote({
    required String title,
    required int category,
    required String date,
    required String time,
    required String description,
  }) async {
    var db = await getDB();
    int rowsAffected = await db.insert(TABLE_NOTE, {
      COLUMN_TABLE_TITLE : title,
      COLUMN_TABLE_CATEGORY : category,
      COLUMN_TABLE_DATE : date,
      COLUMN_TABLE_TIME : time,
      COLUMN_TABLE_DESCRIPTION : description,
    });
    return rowsAffected > 0;
  }

  //fetching
  Future<List<Map<String, dynamic>>> getAllNotes() async {
    var db = await getDB();
    List<Map<String, dynamic>> data = await db.query(TABLE_NOTE);
    return data;
  }
}