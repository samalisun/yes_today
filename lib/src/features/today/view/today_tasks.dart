import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:yes_today/src/shared/providers/providers.dart';

import '../../../shared/classes/classes.dart';
import '../../../shared/views/views.dart';

class TodayTasks extends StatefulWidget {
  const TodayTasks({Key? key}) : super(key: key);

  @override
  State<TodayTasks> createState() => _TodayTasksState();
}

class _TodayTasksState extends State<TodayTasks> {
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<TasksProvider>(context);
    final tasksOfToday = tasks.tasksOfToday;
    final DateFormat formatter = DateFormat('E MMM dd, yyyy');

    return ListView(
      children: [
        Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              formatter.format(tasksOfToday[0].dueDate),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            )),
        ...tasksOfToday.map<Widget>((Task todo) {
          return TaskItem(task: todo);
        }).toList(),
      ],
    );
  }
}
