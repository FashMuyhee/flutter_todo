import 'package:hive_flutter/hive_flutter.dart';

class TodoDatabase {
  List todos = [];

  final todoBox = Hive.box('_todo_box');

  void createInitialData() {
    todos = [
      {'id': 1, 'taskName': "Welcome David", 'taskCompleted': true},
    ];
  }

  void loadDb() {
    todos = todoBox.get('TODOS');
  }

  void updateDb() {
    todoBox.put('TODOS', todos);
  }
}
