import 'package:flutter/material.dart';
import 'package:todo/widgets/new_todo_dialog.dart';
import 'package:todo/widgets/todo_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _textController = TextEditingController();

  List<Map<String, dynamic>> todos = [
    {'id': 1, 'taskName': "Buy groceries", 'taskCompleted': false},
    {'id': 2, 'taskName': "Finish report", 'taskCompleted': true},
    {'id': 3, 'taskName': "Call the dentist", 'taskCompleted': false},
  ];

  void onSaveTodo() {
    Navigator.of(context).pop();
    if (_textController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'To do required',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red.shade500,
        ),
      );
      return;
    }
    int lastTodoId = todos.isNotEmpty ? todos.last['id'] : 1;
    final todo = {
      'id': lastTodoId + 1,
      'taskName': _textController.text,
      'taskCompleted': false
    };
    todos.add(todo);
    setState(() {});
  }

  void onRemoveTodo(int index) {
    todos.removeAt(index);
    setState(() {});
  }

  void createTodo() {
    _textController.clear();
    showDialog(
        context: context,
        builder: (context) {
          return NewTodoDialog(
            onCancel: () => Navigator.of(context).pop(),
            onSave: onSaveTodo,
            controller: _textController,
          );
        });
  }

  void onToggleCompleted(bool? status, int index) {
    todos[index]['taskCompleted'] = !todos[index]['taskCompleted'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TO DOS',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createTodo,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final item = todos[index];
          return TodoTitle(
            onChanged: (v) => onToggleCompleted(v, index),
            taskCompleted: item['taskCompleted'],
            taskName: item['taskName'],
            onDelete: (context) => onRemoveTodo(index),
          );
        },
      ),
    );
  }
}
