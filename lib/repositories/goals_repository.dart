import 'package:flutter/material.dart';

import '../database/database_manager.dart';
import '../models/goal.dart';

class GoalsRepository extends ChangeNotifier {
  List<Goal> _goals = [];
  bool isInitalized = false;

  void _initGoals() async {
    _goals = await DatabaseManager.instance.fetchGoals();
    notifyListeners();
  }

  void saveGoal(var goal) {
    if (goal.id != -1) {
      _updateGoal(goal);
    } else {
      _addGoal(goal);
    }
  }

  void _addGoal(var goal) async {
    goal.id = await DatabaseManager.instance.addGoal(goal);
    _goals.add(goal);

    notifyListeners();
  }

  void _updateGoal(var goal) {
    DatabaseManager.instance.updateGoal(goal);

    int goalIndex = _goals.indexWhere((element) => element.id == goal.id);
    _goals[goalIndex] = goal;

    notifyListeners();
  }

  List<Goal> getGoals() {
    if (!isInitalized) {
      _initGoals();
      isInitalized = true;
    }

    return _goals;
  }

  List<Goal> getGoalsByWeekday(int weekday) {
    List<Goal> filteredGoals = [];

    for (var goal in getGoals()) {
      if (goal.days[weekday]) {
        filteredGoals.add(goal);
      }
    }
    return filteredGoals;
  }

  void deleteGoal(var goal) {
    DatabaseManager.instance.deleteGoal(goal);
    _goals.remove(goal);
    notifyListeners();
  }
}
