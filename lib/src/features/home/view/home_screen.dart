import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/providers/providers.dart';
import '../../today/today.dart';
import '../home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;
  final TextEditingController _textFieldController = TextEditingController();
  String newTaskTitle = '';
  bool newTaskCompleted = false;

  @override
  void initState() {
    super.initState();
    _textFieldController.addListener(() {
      newTaskTitle = _textFieldController.text;
    });
  }

  void _addTask() {
    Provider.of<TasksProvider>(context, listen: false).addTask(newTaskTitle);
    Navigator.pop(context, 'Add');
    _textFieldController.clear();
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  Future<void> _openModal(BuildContext context) async {
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                child: TextField(
                  autofocus: true,
                  controller: _textFieldController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Task name',
                    suffixIcon: Icon(Icons.arrow_forward),
                  ),
                  onSubmitted: (_) => _addTask(),
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home'),
      ),
      body: <Widget>[
        const HomeTasks(),
        const TodayTasks(),
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
          onPressed: () => _openModal(context),
          tooltip: 'Add Item',
          child: const Icon(Icons.edit)),
    );
  }
}
