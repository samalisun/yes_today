import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../features/today/view/today_screen.dart';
import 'providers/providers.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => TodosProvider()),
      child: MaterialApp(
        title: 'Yes!Today',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          useMaterial3: true,
        ),
        home: const TodayScreen(),
      ),
    );
  }
}
