import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreatePanel extends StatefulWidget {
  final Function addTask;

  const CreatePanel({super.key, required this.addTask});

  @override
  State<CreatePanel> createState() => _CreatePanelState();
}

class _CreatePanelState extends State<CreatePanel> {
  final TextEditingController _textFieldController = TextEditingController();
  final DateFormat formatter = DateFormat('E MMM dd');

  String title = '';
  bool isBlocker = false;
  bool isImportant = false;
  DateTime selectedDate = DateTime.now();

  // List<bool> typeSelected = [true, false];

  @override
  void initState() {
    super.initState();
    _textFieldController.addListener(() {
      title = _textFieldController.text;
    });
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      height: 180,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                autofocus: true,
                controller: _textFieldController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: colors.background,
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  hintText: 'Task name',
                  suffixIcon: const Icon(Icons.arrow_forward),
                ),
                onSubmitted: (_) => widget.addTask(
                  title,
                  selectedDate,
                  // typeSelected[0] ? 'task' : 'blocker',
                  isBlocker,
                  isImportant,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2023),
                        lastDate: DateTime(2024),
                      ).then((pickedDate) {
                        if (pickedDate == null) {
                          return;
                        }
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      });
                    },
                    icon: const Icon(
                      Icons.today_outlined,
                      size: 18,
                    ),
                    label: Text(
                        DateUtils.isSameDay(selectedDate, DateTime.now())
                            ? 'Today'
                            : formatter.format(selectedDate).toString()),
                  ),
                  const Padding(padding: EdgeInsets.only(right: 16)),
                  // ToggleButtons(
                  //   isSelected: typeSelected,
                  //   textStyle: const TextStyle(fontSize: 14),
                  //   renderBorder: true,
                  //   borderRadius: BorderRadius.circular(24),
                  //   color: colors.onSurfaceVariant,
                  //   selectedBorderColor: colors.primary,
                  //   selectedColor: colors.primary,
                  //   onPressed: (int index) {
                  //     setState(() {
                  //       for (int i = 0; i < typeSelected.length; i++) {
                  //         typeSelected[i] = i == index;
                  //       }
                  //     });
                  //   },
                  //   constraints: const BoxConstraints(
                  //     minHeight: 38,
                  //   ),
                  //   children: const [
                  //     Padding(
                  //       padding: EdgeInsets.fromLTRB(16, 0, 12, 0),
                  //       child: Text('Task'),
                  //     ),
                  //     Padding(
                  //       padding: EdgeInsets.fromLTRB(12, 0, 16, 0),
                  //       child: Text('Blocker'),
                  //     ),
                  //   ],
                  // ),
                  OutlinedButton.icon(
                    onPressed: () {
                      setState(() {
                        isBlocker = !isBlocker;
                      });
                    },
                    icon: const Icon(
                      Icons.bookmark_outline,
                      size: 18,
                    ),
                    label: Text(isBlocker ? 'Blocker' : 'Task'),
                  ),
                  const Padding(padding: EdgeInsets.only(right: 16)),
                  IconButton(
                    icon: const Icon(Icons.star_border_outlined),
                    selectedIcon: const Icon(Icons.star),
                    isSelected: isImportant,
                    onPressed: () {
                      setState(() {
                        isImportant = !isImportant;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
