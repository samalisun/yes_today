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
    final todos = Provider.of<TodosProvider>(context);
    final openTodos = todos.openTodos;
    final completedTodos = todos.completedTodos;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text('Todo', style: TextStyle(fontSize: 18)),
        ),
        ...openTodos.map<Widget>((Todo todo) {
          return TodoItem(todo: todo);
        }).toList(),
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text('Completed', style: TextStyle(fontSize: 18)),
        ),
        ...completedTodos.map<Widget>((Todo todo) {
          return TodoItem(todo: todo);
        }).toList()
      ],
    );
  }
}
