import 'dart:collection';

import 'package:flutter/cupertino.dart';

import '../classes/classes.dart';

class TasksProvider with ChangeNotifier {
  static TasksProvider get shared => TasksProvider();

  final List<Task> _tasks = [
    Task(
      title: 'Complete the component animation update',
      createdTime: DateTime.parse('2022-12-16'),
      id: DateTime.now().microsecondsSinceEpoch,
      dueDate: DateTime.parse('2022-12-16'),
      completed: true,
    ),
    Task(
      title: 'Design review',
      createdTime: DateTime.parse('2022-12-16'),
      id: DateTime.now().microsecondsSinceEpoch,
      dueDate: DateTime.parse('2022-12-16'),
      completed: true,
    ),
    Task(
      title: 'add test cases for the search logic',
      createdTime: DateTime.parse('2022-12-16'),
      id: DateTime.now().microsecondsSinceEpoch,
      dueDate: DateTime.parse('2022-12-16'),
      completed: true,
    ),
    Task(
      title: 'Create common utilities functions for component test with store',
      createdTime: DateTime.now(),
      id: DateTime.parse('2022-12-16').microsecondsSinceEpoch,
      dueDate: DateTime.now(),
      completed: true,
    ),
    Task(
      title:
          'Update existing test cases to implement common functions when rendering for test',
      createdTime: DateTime.now(),
      id: DateTime.now().microsecondsSinceEpoch,
      dueDate: DateTime.now(),
      important: true,
    ),
    Task(
      title: 'Write api test case',
      createdTime: DateTime.now(),
      id: DateTime.now().microsecondsSinceEpoch,
      dueDate: DateTime.now(),
    ),
  ];

  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);

  void addTask(String title) {
    _tasks.add(Task(
      title: title,
      id: DateTime.now().microsecondsSinceEpoch,
      createdTime: DateTime.now(),
      dueDate: DateTime.now(),
    ));
    notifyListeners();
  }

  void toggleTaskStatus(Task task) {
    final taskIndex = _tasks.indexOf(task);
    _tasks[taskIndex].toggleCompleted();
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }

  getTaskOfTodaySorted(List<Task> tasks) {
    List<Task> completedTasks =
        tasks.where((task) => task.completed == true).toList();
    List<Task> openTasks =
        tasks.where((task) => task.completed == false).toList();
    return [...completedTasks, ...openTasks];
  }

  List<Task> get completedTasks =>
      _tasks.where((task) => task.completed == true).toList();

  List<Task> get openTasks =>
      _tasks.where((task) => task.completed == false).toList();

  List<Task> get tasksOfToday => _tasks
      .where((task) =>
          task.dueDate.year == DateTime.now().year &&
          task.dueDate.month == DateTime.now().month &&
          task.dueDate.day == DateTime.now().day)
      .toList();
}
