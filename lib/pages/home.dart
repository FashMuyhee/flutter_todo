import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/db/TodoDatabase.dart';
import 'package:todo/widgets/new_todo_dialog.dart';
import 'package:todo/widgets/todo_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _textController = TextEditingController();

  final _todoBox = Hive.box('_todo_box');

  TodoDatabase db = TodoDatabase();

  @override
  void initState() {
    if (_todoBox.get('TODOS') == null) {
      db.createInitialData();
    } else {
      db.loadDb();
    }
    super.initState();
  }

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
    int lastTodoId = db.todos.isNotEmpty ? db.todos.last['id'] : 1;
    final todo = {
      'id': lastTodoId + 1,
      'taskName': _textController.text,
      'taskCompleted': false
    };
    db.todos.add(todo);
    db.updateDb();
    setState(() {});
  }

  void onRemoveTodo(int index) {
    db.todos.removeAt(index);
    db.updateDb();
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
    db.todos[index]['taskCompleted'] = !db.todos[index]['taskCompleted'];
    db.updateDb();
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
        itemCount: db.todos.length,
        itemBuilder: (context, index) {
          final item = db.todos[index];
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
