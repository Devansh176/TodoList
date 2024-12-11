import 'package:flutter/material.dart';
import 'package:todo_list/NewTask.dart';
import 'package:todo_list/data/local/dbConnection.dart';

import 'Task.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  List<Map<String, dynamic>> allNotes = [];
  DBConnection? dbRef;

  late DateTime selectedDate;
  late String date;

  @override
  void initState(){
    super.initState();
    selectedDate = DateTime.now();
    date = formatDate(selectedDate);
    dbRef = DBConnection.getInstance;
    getNotes();
  }

  void getNotes() async {
    allNotes = await dbRef!.getAllNotes();
    setState(() {

    });
  }

  String formatDate(DateTime date){
    return '${date.day} / ${date.month} / ${date.year}';
  }

  final List<TodoItem> _incompleteTodoItems = [];
  final List<TodoItem> _completedTodoItems = [];
  final List<Task> _tasks = [];

  void _addNewTask(Task task) {
    setState(() {
      _tasks.add(task);
    });
  }
  void _toggleTodoStatus(int index, bool isCompleted) {
    setState(() {
      if (isCompleted) {
        final item = _completedTodoItems.removeAt(index);
        item.isDone = false;
        _incompleteTodoItems.add(item);
      } else {
        final item = _incompleteTodoItems.removeAt(index);
        item.isDone = true;
        _completedTodoItems.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double height = screenSize.height;
    final double width = screenSize.width;

    final double containerHeight = height * 0.24;
    final double listItemHeight = height * 0.24;
    final double padding = width * 0.05;
    final double fontSize = width * 0.06;
    final double headerFontSize = width * 0.10;
    final double shadowSpreadRadius = width * 0.01;
    final double shadowBlurRadius = width * 0.03;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: height,
                child: _head(
                  containerHeight: containerHeight,
                  listItemHeight: listItemHeight,
                  padding: padding,
                  fontSize: fontSize,
                  headerFontSize: headerFontSize,
                  shadowSpreadRadius: shadowSpreadRadius,
                  shadowBlurRadius: shadowBlurRadius,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _head({
    required double containerHeight,
    required double listItemHeight,
    required double padding,
    required double fontSize,
    required double headerFontSize,
    required double shadowSpreadRadius,
    required double shadowBlurRadius,
  }) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              height: containerHeight,
              decoration: BoxDecoration(
                color: Colors.amberAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(padding * 0.9),
                  bottomRight: Radius.circular(padding * 0.9),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: padding * 2.0,
                    right: padding * 1.2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: padding * 1.2,
                      left: padding,
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: padding * 1.9,
          left: padding,
          right: padding,
          child: Column(
            children: [
              TextButton(
                onPressed: () => selectedDate,
                child: Text(
                  date,
                  style: TextStyle(
                      fontFamily: 'PlaywriteGBS',
                      fontSize: fontSize * 1.2,
                      fontWeight: FontWeight.w800,
                      color: Colors.white
                  ),
                ),
              ),
              SizedBox(height: padding * 0.3,),
              Center(
                child: Text(
                  "My Todo List",
                  style: TextStyle(
                    fontFamily: 'PlaywriteGBS',
                    fontSize: fontSize * 2.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: padding * 0.9),
              Container(
                height: listItemHeight,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.amber,
                      offset: Offset(0, shadowSpreadRadius),
                      blurRadius: shadowBlurRadius,
                      spreadRadius: shadowSpreadRadius,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.all(padding * 0.3),
                  child: _todoList(
                    items: _incompleteTodoItems,
                    isCompleted: false,
                  ),
                ),
              ),
              SizedBox(height: padding * 2.7),
              Text(
                'Completed',
                style: TextStyle(
                  fontFamily: 'PlaywriteGBS',
                  fontSize: fontSize * 1.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: padding * 0.8,),
              Container(
                height: listItemHeight,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.amber,
                      offset: Offset(0, shadowSpreadRadius),
                      blurRadius: shadowBlurRadius,
                      spreadRadius: shadowSpreadRadius,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.all(padding * 0.3),
                  child: _todoList(
                    items: _completedTodoItems,
                    isCompleted: true,
                  ),
                ),
              ),
              SizedBox(height: padding * 1.3,),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewTask(
                        onAddTask: _addNewTask,
                      ),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  side: MaterialStateProperty.all(const BorderSide(color: Colors.amber)),
                ),
                child: Text(
                  '    Add New Task    ',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontFamily: 'PlaywriteGBS',
                    fontSize: fontSize * 1.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _todoList({required bool isCompleted, required List<TodoItem> items}) {
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      itemCount: _tasks.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Checkbox(
            value: _tasks[index].isDone,
            onChanged: (value) {
              _toggleTodoStatus(index, _tasks[index].isDone);
            },
          ),
          title: Text(
            _tasks[index].title,
            style: TextStyle(
              fontFamily: 'PlaywriteGBS',
              decoration: _tasks[index].isDone
                  ? TextDecoration.none
                  : TextDecoration.none,
            ),
          ),
          subtitle: Text(
            '${_tasks[index].date.day}/${_tasks[index].date.month}/${_tasks[index].date.year} ${_tasks[index].time.format(context)}',
            style: const TextStyle(
              fontFamily: 'PlaywriteGBS',
            ),
          ),
        );
      },
    );
  }
}

class TodoItem {
  String title;
  bool isDone;

  TodoItem(this.title, this.isDone);
}
