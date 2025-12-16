import 'package:i12_into_012/models/app_state.dart';
import 'package:i12_into_012/models/todo.dart';

abstract class AppStateStorage {
  Future<AppState> loadInitial();

  Future<void> insertTodo(Todo todo);
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodos(Set<String> ids);

  Future<void> saveSettings({
    required bool isDarkMode,
    required bool asksForDeletionConfirmation,
  });
}
