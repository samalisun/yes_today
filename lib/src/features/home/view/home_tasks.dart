import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:yes_today/src/shared/providers/providers.dart';

import '../home.dart';

class HomeTasks extends StatefulWidget {
  const HomeTasks({Key? key}) : super(key: key);

  @override
  State<HomeTasks> createState() => _HomeTasksState();
}

class _HomeTasksState extends State<HomeTasks> {
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<TasksProvider>(context);
    final datesWithTasks = tasks.datesWithTasks;

    return CustomScrollView(
      slivers: [
        ...datesWithTasks.map<Widget>((DateTime day) {
          return HomeDay(
            date: day,
            isLast: datesWithTasks.indexOf(day) == datesWithTasks.length - 1,
          );
        }),
      ],
    );
  }
}
