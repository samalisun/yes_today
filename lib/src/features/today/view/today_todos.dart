import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_today/src/shared/providers/providers.dart';

import '../../../shared/classes/classes.dart';
import '../../../shared/views/views.dart';

class TodayTodos extends StatefulWidget {
  const TodayTodos({Key? key}) : super(key: key);

  @override
  State<TodayTodos> createState() => _TodayTodosState();
}

class _TodayTodosState extends State<TodayTodos> {
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<TasksProvider>(context);
    final tasksOfToday = tasks.tasksOfToday;

    return ListView(
      children: [
        ...tasksOfToday.map<Widget>((Task todo) {
          return TodoItem(task: todo);
        }).toList(),
      ],
    );
  }
}
