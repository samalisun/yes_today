import 'dart:collection';

import 'package:flutter/cupertino.dart';

import '../classes/classes.dart';

class TodosProvider with ChangeNotifier {
  static TodosProvider get shared => TodosProvider();

  final List<Todo> _todos = [];

  UnmodifiableListView<Todo> get todos => UnmodifiableListView(_todos);

  void addTodo(String title) {
    _todos.add(Todo(title: title));
    notifyListeners();
  }

  void toggleTodoStatus(Todo todo) {
    final todoIndex = _todos.indexOf(todo);
    _todos[todoIndex].toggleCompleted();
    notifyListeners();
  }

  void deleteTodo(Todo todo) {
    _todos.remove(todo);
    notifyListeners();
  }

  List<Todo> get completedTodos =>
      _todos.where((todo) => todo.completed == true).toList();

  List<Todo> get openTodos =>
      _todos.where((todo) => todo.completed == false).toList();
}
