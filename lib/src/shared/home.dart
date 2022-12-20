import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/providers.dart';
import '../features/home/home.dart';
import '../features/today/today.dart';
import '../features/review/review.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  final TextEditingController _textFieldController = TextEditingController();
  final List<String> titleList = ['Home', 'Today', 'Review'];
  final List<Icon> iconList = [
    const Icon(Icons.filter_alt_outlined),
    const Icon(Icons.sticky_note_2_outlined),
    const Icon(Icons.lightbulb_outline),
  ];

  String newTaskTitle = '';
  bool newTaskCompleted = false;

  int currentPageIndex = 0;
  String title = 'Home';

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
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
        actions: [
          IconButton(
            icon: iconList[currentPageIndex],
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromRGBO(33, 36, 42, 1),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            SizedBox(
              height: 200,
              child: DrawerHeader(
                padding: const EdgeInsets.all(0),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(33, 36, 42, 1),
                  border: null,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('YesToday', style: TextStyle(fontSize: 18)),
                    Container(
                      margin: const EdgeInsets.only(top: 24),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: colors.primaryContainer,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const <Widget>[
                                  Text('Kristen', style: TextStyle(fontSize: 16)),
                                  Padding(padding: EdgeInsets.only(bottom: 4)),
                                  Text('Developer', style: TextStyle(fontSize: 12)),
                                ],
                              ),
                            ),
                          ),
                          const Icon(Icons.settings)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const ListTile(
              title: Text('Projects'),
            ),
            ListTile(
              // contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              leading: const Icon(Icons.folder),
              title: const Text('Webdex'),
              selected: true,
              selectedTileColor: colors.primaryContainer,
              selectedColor: colors.onPrimaryContainer,
              onTap: () {
                Navigator.pop(context);
              },
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100))),
            ),
            ListTile(
              // contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              leading: const Icon(Icons.folder_outlined),
              title: const Text('QAclub'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: <Widget>[
        const HomeTasks(),
        const TodayTasks(),
        const ReviewScreen(),
      ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
            title = titleList[index];
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
