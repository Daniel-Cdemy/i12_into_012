import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i12_into_012/models/app_state.dart';
import 'package:i12_into_012/providers/sqflite_provider.dart';

final appStateProvider = NotifierProvider<AppStateNotifier, AppState>(() {
  return SqfliteProvider();
});

abstract class AppStateNotifier extends Notifier<AppState> {
  Future<void> loadState();

  Future<void> saveState();

  void addTodo(String text);

  void toggleTodo(String id);

  void toggleSelection(String id);

  void clearSelection();

  Future<void> deleteSelectedTodos();

  void toggleDarkMode();

  void toggleDeletionConfirmation();
}
