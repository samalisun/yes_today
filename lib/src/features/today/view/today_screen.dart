import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/providers/providers.dart';
import '../today.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  int currentPageIndex = 0;
  final TextEditingController _textFieldController = TextEditingController();
  String newTaskTitle = '';

  @override
  void initState() {
    super.initState();
    _textFieldController.addListener(() {
      newTaskTitle = _textFieldController.text;
    });
  }

  void _submit() {
    Provider.of<TasksProvider>(context, listen: false).addTask(newTaskTitle);
    Navigator.pop(context, 'Add');
    _textFieldController.clear();
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  Future<void> _displayDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add a new todo item'),
          content: TextField(
            autofocus: true,
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: "Add New Task"),
            onSubmitted: (_) => _submit(),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: _submit,
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Today'),
      ),
      body: <Widget>[
        Container(
          alignment: Alignment.center,
          child: const Text('Home'),
        ),
        const TodayTodos(),
        Container(
          alignment: Alignment.center,
          child: const Text('Review'),
        ),
      ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.check_box),
            icon: Icon(Icons.check_box_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.today),
            icon: Icon(Icons.today_outlined),
            label: 'Today',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.summarize),
            icon: Icon(Icons.summarize_outlined),
            label: 'Review',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _displayDialog(context),
          tooltip: 'Add Item',
          child: const Icon(Icons.edit)),
    );
  }
}
