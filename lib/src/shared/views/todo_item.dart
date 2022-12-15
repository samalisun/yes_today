import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../classes/classes.dart';
import '../providers/providers.dart';

class TodoItem extends StatelessWidget {
  TodoItem({
    required this.task,
  }) : super(key: ObjectKey(task));

  final Task task;

  @override
  Widget build(BuildContext context) {
    final todos = Provider.of<TasksProvider>(context);
    final colors = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 16),
      decoration: BoxDecoration(
        border: Border.all(
            color: task.completed ? colors.background : colors.outline),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(0, 8, 16, 8),
        minLeadingWidth: 32,
        horizontalTitleGap: 8,
        leading: IconButton(
          icon: task.completed
              ? const Icon(Icons.check)
              : const Icon(Icons.radio_button_unchecked),
          color: task.important ? colors.primary : colors.onBackground,
          tooltip: 'Toggle task status',
          onPressed: () {
            todos.toggleTaskStatus(task);
          },
        ),
        title: Text(task.title, style: TextStyle(height: 1.5, color: colors.onBackground)),
      ),
    );
  }
}
