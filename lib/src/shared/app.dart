import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../features/today/today.dart';
import 'providers/providers.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final settings = ValueNotifier(ThemeSettings(
    sourceColor: const Color.fromRGBO(0, 69, 142, 1),
    themeMode: ThemeMode.dark,
  ));

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => TasksProvider()),
      child: DynamicColorBuilder(
          builder: (lightDynamic, darkDynamic) => ThemeProvider(
              settings: settings,
              lightDynamic: lightDynamic,
              darkDynamic: darkDynamic,
              child: NotificationListener<ThemeSettingChange>(
                onNotification: (notification) {
                  settings.value = notification.settings;
                  return true;
                },
                child: ValueListenableBuilder<ThemeSettings>(
                  valueListenable: settings,
                  builder: (context, value, _) {
                    final theme = ThemeProvider.of(context);

                    return MaterialApp(
                      title: 'Yes!Today',
                      theme: theme.light(settings.value.sourceColor),
                      darkTheme: theme.dark(settings.value.sourceColor),
                      themeMode: theme.themeMode(),
                      home: const TodayScreen(),
                    );
                  },
                ),
              ))),
    );
  }
}
