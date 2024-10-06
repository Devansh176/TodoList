import 'package:flutter/material.dart';

class Task {
  String title;
  DateTime date;
  TimeOfDay time;
  bool isDone;

  Task(this.title, this.date, this.time, {this.isDone = false});
}
