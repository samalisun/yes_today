import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../shared/classes/classes.dart';
import '../../../shared/providers/providers.dart';
import '../../../shared/views/views.dart';

class HomeDay extends StatelessWidget {
  HomeDay({
    required this.date,
  }) : super(key: ObjectKey(date));

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<TasksProvider>(context);
    final List<Task> tasksOfTheDay = tasks.getTaskByDate(date);

    final tasksCount = tasksOfTheDay.length;
    final trailing =
        '${tasksCount.toString()} ${tasksCount > 0 ? ' tasks' : ' tasks'}';

    final DateFormat formatter = DateFormat('E MMM dd, yyyy');
    final title = formatter.format(date);

    return SliverList(
      delegate: SliverChildListDelegate([
        Container(
          margin: const EdgeInsets.only(bottom: 24),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Theme.of(context).colorScheme.outline)),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
            title: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            trailing: Text(
              trailing,
            ),
          ),
        ),
        ...tasksOfTheDay.map<Widget>((Task todo) {
          return TaskItem(task: todo);
        }).toList(),
        const Padding(padding: EdgeInsets.only(bottom: 24)),
      ]),
    );
  }
}
