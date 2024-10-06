import 'package:flutter/material.dart';

import 'Task.dart';

class NewTask extends StatefulWidget {
  final Function(Task) onAddTask;

  const NewTask({super.key, required this.onAddTask});

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final TextEditingController taskController = TextEditingController();

  late DateTime selectDate;
  late String date;
  late TimeOfDay selectTime;
  late String time;

  @override
  void initState() {
    super.initState();
    selectDate = DateTime.now();
    selectTime = TimeOfDay.now();
    date = formatDate(selectDate);
    time = formatTime(selectTime);
  }

  String formatDate(DateTime date) {
    return '${date.day} / ${date.month} / ${date.year}';
  }

  String formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pick = await showDatePicker(
      context: context,
      initialDate: selectDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pick != null && pick != selectDate) {
      setState(() {
        selectDate = pick;
        date = formatDate(pick);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pick = await showTimePicker(
      context: context,
      initialTime: selectTime,
    );
    if (pick != null && pick != selectTime) {
      setState(() {
        selectTime = pick;
        time = formatTime(pick);
      });
    }
  }

  void _saveTask() {
    final taskTitle = taskController.text;
    if (taskTitle.isNotEmpty) {
      final newTask = Task(taskTitle, selectDate, selectTime);
      widget.onAddTask(newTask);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;
    final double padding = width * 0.05;
    final double fontSize = width * 0.06;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber,
        title: Text(
          'Add New Task',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'PlaywriteGBS',
            fontWeight: FontWeight.w900,
            fontSize: fontSize * 1.5,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(padding * 1.2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Task Title',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'PlaywriteGBS',
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize * 1.2,
                  ),
                ),
                SizedBox(height: padding * 0.7),
                TextField(
                  controller: taskController,
                  cursorColor: Colors.amber,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    hintText: "Enter Task Title",
                  ),
                  style: const TextStyle(
                    fontFamily: 'PlaywriteGBS',
                  ),
                ),
                SizedBox(height: padding * 2.5),
                Text(
                  'Category',
                  style: TextStyle(
                    fontFamily: 'PlaywriteGBS',
                    fontSize: fontSize * 1.2,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: padding * 0.4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.indigo,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.school, size: fontSize * 1.0, color: Colors.white), // Set icon color to contrast with background
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.cyan,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.account_circle_rounded, size: fontSize * 1.0, color: Colors.white), // Set icon color to contrast with background
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.orangeAccent,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.add_chart_rounded, size: fontSize * 1.0, color: Colors.white), // Set icon color to contrast with background
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.pink,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.health_and_safety, size: fontSize * 1.0, color: Colors.white), // Set icon color to contrast with background
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.brown,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.home, size: fontSize * 1.0, color: Colors.white), // Set icon color to contrast with background
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.teal,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.date_range, size: fontSize * 1.0, color: Colors.white), // Set icon color to contrast with background
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                SizedBox(height: padding * 2.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: padding * 2.5),
                      child: Text(
                        'Date',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'PlaywriteGBS',
                          fontSize: fontSize * 1.2,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: padding * 2.5),
                      child: Text(
                        'Time',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'PlaywriteGBS',
                          fontSize: fontSize * 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: padding * 0.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(color: Colors.greenAccent),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: padding * 1.0),
                        height: padding * 3.0,
                        child: Row(
                          children: [
                            Expanded(
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  date,
                                  style: TextStyle(
                                    fontSize: fontSize * 1.2,
                                    fontFamily: 'PlaywriteGBS',
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () => _selectDate(context),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.green, backgroundColor: Colors.white,
                              ),
                              icon: Icon(
                                Icons.calendar_today,
                                color: Colors.green,
                                size: fontSize * 0.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: padding * 1.1),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(color: Colors.greenAccent),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: padding * 1.4),
                        height: padding * 3.0,
                        child: Row(
                          children: [
                            Expanded(
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  time,
                                  style: TextStyle(
                                    fontSize: fontSize * 1.2,
                                    fontFamily: 'PlaywriteGBS',
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () => _selectTime(context),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.green, backgroundColor: Colors.white,
                              ),
                              icon: Icon(
                                Icons.access_time,
                                color: Colors.green,
                                size: fontSize * 0.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: padding * 2.5,),
                Text(
                  'Notes',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PlaywriteGBS',
                    fontSize: fontSize * 1.2,
                  ),
                ),
                SizedBox(height: padding * 1.0,),
                SizedBox(
                  height: padding * 6,
                  child: TextField(
                    controller: taskController,
                    cursorColor: Colors.amber,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      hintText: "Notes here...",
                      contentPadding: EdgeInsets.symmetric(
                        vertical: padding * 2,
                        horizontal: padding * 0.5,
                      ),
                    ),
                    style: const TextStyle(
                      fontFamily: 'PlaywriteGBS',
                    ),
                  ),
                ),
                SizedBox(height: padding * 0.1,),

                Padding(
                  padding: EdgeInsets.only(left: padding * 5.0),
                  child: ElevatedButton(
                    onPressed:
                      _saveTask,
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        side: MaterialStateProperty.all(const BorderSide(color: Colors.green))
                    ),
                    child: Text(
                      '     Save     ',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontFamily: 'PlaywriteGBS',
                          fontSize: fontSize * 1.0,
                          color: Colors.black
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
