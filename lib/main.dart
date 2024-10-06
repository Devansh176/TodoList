import 'package:flutter/material.dart';
import 'package:todo_list/NewTask.dart';
import 'package:todo_list/Todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Todo(),
    );
  }
}