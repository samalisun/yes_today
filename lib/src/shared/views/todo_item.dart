import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../classes/classes.dart';
import '../providers/providers.dart';

class TodoItem extends StatelessWidget {
  TodoItem({
    required this.todo,
  }) : super(key: ObjectKey(todo));

  final Todo todo;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  Icon _getIcon(bool checked) {
    if (checked) {
      return const Icon(Icons.radio_button_checked);
    } else {
      return const Icon(Icons.radio_button_unchecked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final todos = Provider.of<TodosProvider>(context);

    return ListTile(
      onTap: () {
        todos.toggleTodoStatus(todo);
      },
      leading: IconButton(
        icon: _getIcon(todo.completed),
        color: Colors.grey,
        tooltip: 'Delete todo',
        onPressed: () {
          todos.toggleTodoStatus(todo);
        },
      ),
      title: Text(todo.title, style: _getTextStyle(todo.completed)),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline),
        color: Colors.grey,
        tooltip: 'Delete todo',
        onPressed: () {
          todos.deleteTodo(todo);
        },
      ),
    );
  }
}