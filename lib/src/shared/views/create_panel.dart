import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreatePanel extends StatefulWidget {
  final Function onSubmit;

  const CreatePanel({super.key, required this.onSubmit});

  @override
  State<CreatePanel> createState() => _CreatePanelState();
}

class _CreatePanelState extends State<CreatePanel> {
  // date time
  final now = DateTime.now();
  final DateFormat formatter = DateFormat('E MMM dd');

  // content
  final String _contentHintText = 'Task name';
  final String _contentRelativeDateToday = 'Today';

  // controllers
  final TextEditingController _textFieldController = TextEditingController();

  String _taskTitle = '';
  bool _taskIsBlocker = false;
  bool _taskIsImportant = false;
  DateTime _taskDate = DateTime.now();
  List<bool> typeSelected = [true, false];

  void _submit() {
    if (_textFieldController.value.text.isNotEmpty) {
      widget.onSubmit(
        _taskTitle,
        _taskDate,
        _taskIsBlocker,
        _taskIsImportant,
      );
    }
  }

  Widget buildTaskTitleInput(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: _textFieldController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.background,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        hintText: _contentHintText,
        suffixIcon: IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed:
              _textFieldController.value.text.isNotEmpty ? _submit : null,
        ),
      ),
      onSubmitted: (_) =>
          _textFieldController.value.text.isNotEmpty ? _submit : null,
    );
  }

  Widget buildDateBtn(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {
        showDatePicker(
          context: context,
          initialDate: _taskDate,
          firstDate: DateTime(now.year, now.month, 1),
          lastDate: DateTime(now.year + 1, 12, 31),
        ).then((pickedDate) {
          if (pickedDate == null) {
            return;
          }
          setState(() {
            _taskDate = pickedDate;
          });
        });
      },
      icon: const Icon(
        Icons.today_outlined,
        size: 18,
      ),
      label: Text(DateUtils.isSameDay(_taskDate, DateTime.now())
          ? _contentRelativeDateToday
          : formatter.format(_taskDate).toString()),
    );
  }

  Widget buildTypeBtn(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {
        setState(() {
          _taskIsBlocker = !_taskIsBlocker;
        });
      },
      icon: const Icon(
        Icons.bookmark_outline,
        size: 18,
      ),
      label: Text(_taskIsBlocker ? 'Blocker' : 'Task'),
    );
  }

  Widget buildToggle(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ToggleButtons(
      isSelected: typeSelected,
      textStyle: const TextStyle(fontSize: 14),
      renderBorder: true,
      borderRadius: BorderRadius.circular(24),
      color: colors.onSurfaceVariant,
      selectedBorderColor: colors.primary,
      selectedColor: colors.primary,
      onPressed: (int index) {
        setState(() {
          for (int i = 0; i < typeSelected.length; i++) {
            typeSelected[i] = i == index;
          }
        });
      },
      constraints: const BoxConstraints(
        minHeight: 38,
      ),
      children: const [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 12, 0),
          child: Text('Task'),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(12, 0, 16, 0),
          child: Text('Blocker'),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _textFieldController.addListener(() {
      _taskTitle = _textFieldController.text;
    });
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 164,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: buildTaskTitleInput(context),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  buildDateBtn(context),
                  const Padding(padding: EdgeInsets.only(right: 16)),
                  IconButton(
                    icon: const Icon(Icons.star_border_outlined),
                    selectedIcon: const Icon(Icons.star),
                    isSelected: _taskIsImportant,
                    onPressed: () {
                      setState(() {
                        _taskIsImportant = !_taskIsImportant;
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
