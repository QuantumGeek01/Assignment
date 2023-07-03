import 'package:flutter/material.dart';

void main() {
  runApp(TaskManagementApp());
}

class TaskManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tasks[index].title),
            subtitle: Text(tasks[index].description),
            onTap: () {
              _openBottomSheet(tasks[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddTaskDialog,
        child: Icon(Icons.add),
      ),
    );
  }

  void _openAddTaskDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String title = '';
        String description = '';
        late DateTime deadline;

        return AlertDialog(
          title: Text('Add Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) => title = value,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                onChanged: (value) => description = value,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                onChanged: (value) => deadline = DateTime.parse(value),
                decoration: InputDecoration(labelText: 'Deadline (yyyy-MM-dd)'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  tasks.add(Task(title, description, deadline));
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _openBottomSheet(Task task) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Task Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text('Title: ${task.title}'),
              Text('Description: ${task.description}'),
              Text('Deadline: ${task.deadline.toString()}'),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    tasks.remove(task);
                  });
                  Navigator.pop(context);
                },
                child: Text('Delete Task'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Task {
  String title;
  String description;
  DateTime deadline;

  Task(this.title, this.description, this.deadline);
}