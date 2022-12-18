import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../classes/classes.dart';
import '../providers/providers.dart';

class TaskItemLeading extends StatelessWidget {
  TaskItemLeading({
    required this.task,
  }) : super(key: ObjectKey(task));

  final Task task;

  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<TasksProvider>(context);
    final colors = Theme.of(context).colorScheme;

    return IconButton(
        icon: task.completed
            ? const Icon(Icons.check, size: 24)
            : const Icon(Icons.radio_button_unchecked, size: 24),
        color: task.important ? colors.primary : colors.onBackground,
        tooltip: 'Toggle task status',
        onPressed: () {
          tasks.toggleTaskStatus(task);
        }
    );
  }
}
