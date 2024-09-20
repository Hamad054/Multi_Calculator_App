import 'package:flutter/material.dart';

void main() {
  runApp(ToDoListApp());
}

class ToDoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ToDoListScreen(),
    );
  }
}

class ToDoListScreen extends StatefulWidget {
  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  final List<Map<String, dynamic>> tasks = [];
  final TextEditingController taskController = TextEditingController();

  void addTask(String task) {
    setState(() {
      tasks.add({'task': task, 'isCompleted': false});
    });
    taskController.clear();
  }

  void toggleTaskCompletion(int index) {
    setState(() {
      tasks[index]['isCompleted'] = !tasks[index]['isCompleted'];
    });
  }

  void editTask(int index, String newTask) {
    setState(() {
      tasks[index]['task'] = newTask;
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Add Task Input
            TextField(
              controller: taskController,
              decoration: InputDecoration(
                labelText: 'Enter a task',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (taskController.text.isNotEmpty) {
                      addTask(taskController.text);
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            // Task List
            Expanded(
              child: tasks.isEmpty
                  ? Center(
                child: Text(
                  'No tasks yet!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              )
                  : ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(tasks[index]['task']),
                    background: slideRightBackground(),
                    secondaryBackground: slideLeftBackground(),
                    onDismissed: (direction) {
                      if (direction == DismissDirection.endToStart) {
                        deleteTask(index);
                      } else {
                        toggleTaskCompletion(index);
                      }
                    },
                    child: ListTile(
                      title: Text(
                        tasks[index]['task'],
                        style: TextStyle(
                          decoration: tasks[index]['isCompleted']
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _editTaskDialog(context, index);
                        },
                      ),
                      leading: Checkbox(
                        value: tasks[index]['isCompleted'],
                        onChanged: (bool? value) {
                          toggleTaskCompletion(index);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Edit Task Dialog
  Future<void> _editTaskDialog(BuildContext context, int index) async {
    TextEditingController editController =
    TextEditingController(text: tasks[index]['task']);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: TextField(
            controller: editController,
            decoration: InputDecoration(hintText: 'Enter new task'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                if (editController.text.isNotEmpty) {
                  editTask(index, editController.text);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Background for swiping right to mark as complete
  Widget slideRightBackground() {
    return Container(
      color: Colors.green,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Icon(Icons.check, color: Colors.white),
        ),
      ),
    );
  }

  // Background for swiping left to delete
  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
    );
  }
}
