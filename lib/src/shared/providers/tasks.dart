import 'dart:collection';

import 'package:flutter/material.dart';

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
      people: 'Cany',
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
    Task(
      title: 'Progress update',
      createdTime: DateTime.now(),
      id: DateTime.now().microsecondsSinceEpoch,
      dueDate: DateUtils.addDaysToDate(DateTime.now(), 1),
      type: 'meeting',
    ),
    Task(
      title: 'Write test case',
      createdTime: DateTime.now(),
      id: DateTime.now().microsecondsSinceEpoch,
      dueDate: DateUtils.addDaysToDate(DateTime.now(), 1),
    ),
    Task(
      title: 'Integrate logic',
      createdTime: DateTime.now(),
      id: DateTime.now().microsecondsSinceEpoch,
      dueDate: DateUtils.addDaysToDate(DateTime.now(), 2),
    ),
  ];

  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);

  void addTask(String title, DateTime date, bool isBlocker, bool isImportant) {
    _tasks.add(Task(
      title: title,
      id: DateTime.now().microsecondsSinceEpoch,
      createdTime: DateTime.now(),
      dueDate: date,
      isBlocker: isBlocker,
      important: isImportant,
    ));
    notifyListeners();
  }

  void toggleTaskStatus(Task task) {
    final taskIndex = _tasks.indexOf(task);
    _tasks[taskIndex].toggleCompleted();
    notifyListeners();
  }

  void toggleTaskPriority(Task task) {
    final taskIndex = _tasks.indexOf(task);
    _tasks[taskIndex].togglePriority();
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }

  getTasksSortedByStatus(List<Task> tasks) {
    List<Task> completedTasks =
        tasks.where((task) => task.completed == true).toList();
    List<Task> openTasks =
        tasks.where((task) => task.completed == false).toList();
    return [...completedTasks, ...openTasks];
  }

  getTaskByDate(DateTime date) {
    return _tasks
        .where((task) => DateUtils.isSameDay(task.dueDate, date))
        .toList();
  }

  List<DateTime> get datesWithTasks {
    List<DateTime> dateList = [];

    for (var task in _tasks) {
      if (dateList
          .where((date) => DateUtils.isSameDay(date, task.dueDate))
          .isEmpty) {
        dateList.add(task.dueDate);
      }
    }

    return dateList;
  }

  List<Task> get completedTasks =>
      _tasks.where((task) => task.completed == true).toList();

  List<Task> get openTasks =>
      _tasks.where((task) => task.completed == false).toList();

  List<Task> get tasksOfToday => _tasks
      .where((task) => DateUtils.isSameDay(task.dueDate, DateTime.now()))
      .toList();

  List<Task> get blockers =>
      _tasks.where((task) => task.isBlocker == true).toList();
}
