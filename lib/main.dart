import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/Todo.dart';
import 'package:todo_list/data/local/dbConnection.dart';
import 'package:todo_list/provider/dBProvider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DBProvider(dbConnection: DBConnection.getInstance),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Todo(),
      ),
    );
  }
}