import 'package:flutter/material.dart';
import 'package:yes_today/src/shared/views/views.dart';

import '../classes/classes.dart';

class TaskItem extends StatelessWidget {
  TaskItem({
    required this.task,
  }) : super(key: ObjectKey(task));

  final Task task;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final bool isToday = DateUtils.isSameDay(task.dueDate, DateTime.now());
    final double marginBottom = isToday ? 16 : 0;
    final double marginLR = isToday ? 24 : 8;

    return Container(
        margin: EdgeInsets.fromLTRB(marginLR, 0, marginLR, marginBottom),
        decoration: BoxDecoration(
          border: Border.all(
              color: !isToday || task.completed
                  ? colors.background
                  : colors.outline),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TaskItemLeading(task: task),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 11, 8, 16),
                    child: Text(
                      task.title,
                      style: const TextStyle(height: 1.5, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
