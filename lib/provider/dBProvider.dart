import 'package:flutter/cupertino.dart';
import 'package:todo_list/data/local/dbConnection.dart';

class DBProvider extends ChangeNotifier {
  late final DBConnection dbConnection;

  DBProvider({required this.dbConnection});

  List<Map<String, dynamic>> _data = [];
  List<Map<String, dynamic>> get getNotes => _data;

  Future<void> addNote(String title, int category, String date, String time, String description) async {
    bool check = await dbConnection.addNote(
      title: title,
      category: category,
      date: date,
      time: time,
      description: description,
    );
    if(check) {
      _data = await dbConnection.getAllNotes();
      notifyListeners();
    }
  }

  Future<void> getInitialNotes() async {
    _data = await dbConnection.getAllNotes();
    notifyListeners();
  }
}