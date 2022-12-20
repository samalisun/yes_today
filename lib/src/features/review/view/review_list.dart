import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../shared/classes/classes.dart';
import '../../../shared/providers/providers.dart';
import '../../../shared/views/views.dart';

class ReviewList extends StatelessWidget {
  ReviewList({
    required this.date,
    required this.tasks,
    required this.isBlocker,
  }) : super(key: ObjectKey(date));

  final DateTime date;
  final List<Task> tasks;
  final bool isBlocker;

  @override
  Widget build(BuildContext context) {
    bool expanded = true;

    final tasks = Provider.of<TasksProvider>(context);
    final List<Task> tasksOfTheDay = tasks.getTaskByDate(date);

    final trailingIcon = expanded ? const Icon(Icons.arrow_drop_up) : const Icon(Icons.arrow_drop_down);

    final title = DateUtils.isSameDay(date, DateTime.now())
        ? 'What am I working on today'
        : 'What did I work on yesterday';
    final DateFormat formatter = DateFormat('E MMM dd, yyyy');
    final subtitle = formatter.format(date);

    final double bottomSpacing = isBlocker ? 96 : 24;

    void toggle () {
      expanded = !expanded;
    }

    return SliverList(
      delegate: SliverChildListDelegate([
        ListTile(
          contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
          title: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              subtitle,
              style: const TextStyle(fontSize: 12),
            ),
          ),
          trailing: IconButton(
            icon: trailingIcon,
            onPressed: () => toggle(),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.outline),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Column(
            children: [
              ...tasksOfTheDay.map<Widget>((Task todo) {
                return TaskItem(task: todo, borderForToday: false);
              }).toList()
            ],
          ),
        ),
        Padding(padding: EdgeInsets.only(bottom: bottomSpacing)),
      ]),
    );
  }
}
