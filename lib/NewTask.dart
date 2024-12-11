import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/provider/dBProvider.dart';
import 'Task.dart';

class NewTask extends StatefulWidget {
  final Function(Task) onAddTask;

  const NewTask({super.key, required this.onAddTask});

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final TextEditingController taskController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  late DateTime selectDate;
  late String date;
  late TimeOfDay selectTime;
  late String time;
  IconData? selectedCategory;

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
    final description = descriptionController.text;

    if (taskTitle.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Task title is required")),
      );
      return;
    }

    if (selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a category")),
      );
      return;
    }

    if (taskTitle.isNotEmpty && selectedCategory != null) {
      context.read<DBProvider>().addNote(
        taskTitle,
        selectedCategory as int,
        date,
        time,
        description,
      );
    }
    Navigator.pop(context);
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
                TextFormField(
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Title is required';
                    }
                    return null;
                  },
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
                SizedBox(height: padding * 0.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCategoryIcon(Icons.school, Colors.indigo,),
                    _buildCategoryIcon(Icons.account_circle_outlined, Colors.cyan,),
                    _buildCategoryIcon(Icons.add_chart_rounded, Colors.orangeAccent,),
                    _buildCategoryIcon(Icons.health_and_safety, Colors.pink,),
                    _buildCategoryIcon(Icons.home, Colors.brown,),
                    _buildCategoryIcon(Icons.date_range, Colors.teal,),
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

  final Map<IconData, int> categoryMap = {
    Icons.school: 1,
    Icons.account_circle_outlined: 2,
    Icons.add_chart_rounded: 3,
    Icons.health_and_safety: 4,
    Icons.home: 5,
    Icons.date_range: 6,
  };

  Widget _buildCategoryIcon(IconData icon, Color color) {
    final screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;
    final double fontSize = width * 0.06;
    final double containerSize = width * 0.11;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = categoryMap[icon] as IconData?;
        });
      },
      child: Container(
        height: containerSize,
        width: containerSize,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: selectedCategory == categoryMap[icon] ? Colors.black : Colors.transparent,
            width: 3.0,
          ),
        ),
        child: Center(
          child: Icon(
            icon,
            size: fontSize,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

}
