import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'repositories/days_repository.dart';
import 'repositories/goals_repository.dart';
import 'route_manager.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GoalsRepository(),
        ),
        ChangeNotifierProvider(
          create: (context) => DaysRepository(),
        ),
      ],
      child: const HabitTrackerApp(),
    ),
  );
}

class HabitTrackerApp extends StatelessWidget {
  const HabitTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Habit Tracker',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
      ),
      initialRoute: 'Home',
      onGenerateRoute: RouteManager.generateRoute,
    );
  }
}
