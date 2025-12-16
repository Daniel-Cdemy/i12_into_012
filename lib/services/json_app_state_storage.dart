import 'dart:convert';
import 'dart:io';

import 'package:i12_into_012/models/app_state.dart';
import 'package:i12_into_012/models/todo.dart';
import 'package:i12_into_012/services/app_state_storage.dart';
import 'package:path_provider/path_provider.dart';

class JsonAppStateStorage implements AppStateStorage {
  Future<File> get _file async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/todo_app_state.json');
  }

  Future<AppState> _readOrDefault() async {
    final file = await _file;
    if (!await file.exists()) return const AppState();
    try {
      final jsonMap =
          jsonDecode(await file.readAsString()) as Map<String, dynamic>;
      return AppState.fromJson(jsonMap);
    } catch (_) {
      return const AppState();
    }
  }

  Future<void> _write(AppState state) async {
    final file = await _file;
    await file.writeAsString(jsonEncode(state.toJson()));
  }

  @override
  Future<AppState> loadInitial() async {
    return _readOrDefault();
  }

  @override
  Future<void> insertTodo(Todo todo) async {
    final current = await _readOrDefault();
    final next = current.copyWith(todos: [...current.todos, todo]);
    await _write(next);
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    final current = await _readOrDefault();
    final nextTodos = current.todos
        .map((t) => t.id == todo.id ? todo : t)
        .toList();
    final next = current.copyWith(todos: nextTodos);
    await _write(next);
  }

  @override
  Future<void> deleteTodos(Set<String> ids) async {
    if (ids.isEmpty) return;
    final current = await _readOrDefault();
    final nextTodos = current.todos.where((t) => !ids.contains(t.id)).toList();
    final next = current.copyWith(todos: nextTodos);
    await _write(next);
  }

  @override
  Future<void> saveSettings({
    required bool isDarkMode,
    required bool asksForDeletionConfirmation,
  }) async {
    final current = await _readOrDefault();
    final next = current.copyWith(
      isDarkMode: isDarkMode,
      asksForDeletionConfirmation: asksForDeletionConfirmation,
    );
    await _write(next);
  }
}
