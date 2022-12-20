import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:yes_today/src/shared/providers/providers.dart';

import '../review.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    final tasks = Provider.of<TasksProvider>(context);

    final datesWithTasks = tasks.datesWithTasks;
    final todayIndex = datesWithTasks.indexOf(datesWithTasks
        .where((date) => DateUtils.isSameDay(date, today))
        .toList()[0]);
    final lastWorkDay = datesWithTasks[todayIndex - 1];

    final lastWorkDayTasks = tasks.getTaskByDate(lastWorkDay);
    final todayTasks = tasks.tasksOfToday;
    final blockers = tasks.blockers;

    return CustomScrollView(
      slivers: [
        ReviewList(
          date: lastWorkDay,
          tasks: lastWorkDayTasks,
          isBlocker: false,
        ),
        ReviewList(
          date: today,
          tasks: todayTasks,
          isBlocker: false,
        ),
        // ...lastWorkDayTasks.map<Widget>((DateTime day) {
        //   return
        // }),
        // ...lastWorkDayTasks.map<Widget>((DateTime day) {
        //   return ReviewList(
        //     date: today,
        //     tasks: todayTasks,
        //     isBlocker: false,
        //   );
        // }),
      ],
    );
  }
}
