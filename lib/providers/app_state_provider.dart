import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i12_into_012/models/app_state.dart';
import 'package:i12_into_012/models/todo.dart';
import 'package:i12_into_012/providers/storage_provider.dart';
import 'package:uuid/uuid.dart';

final appStateProvider = NotifierProvider<AppStateNotifier, AppState>(
  AppStateNotifier.new,
);

class AppStateNotifier extends Notifier<AppState> {
  late final _storage = ref.read(appStateStorageProvider);
  final Uuid _uuid = const Uuid();

  @override
  AppState build() {
    _load();
    return const AppState();
  }

  Future<void> _load() async {
    final loaded = await _storage.loadInitial();
    state = loaded;
  }

  void addTodo(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    final newTodo = Todo(
      id: _uuid.v4(),
      text: trimmed,
    );

    state = state.copyWith(
      todos: [...state.todos, newTodo],
    );

    _storage.insertTodo(newTodo);
  }

  void toggleTodo(String id) {
    final old = state.todos.firstWhere((t) => t.id == id);
    final updatedTodo = old.copyWith(isCompleted: !old.isCompleted);

    final updatedList = state.todos
        .map((t) => t.id == id ? updatedTodo : t)
        .toList();

    state = state.copyWith(todos: updatedList);

    _storage.updateTodo(updatedTodo);
  }

  void toggleSelection(String id) {
    final selected = Set<String>.from(state.selectedTodoIds);
    if (selected.contains(id)) {
      selected.remove(id);
    } else {
      selected.add(id);
    }
    state = state.copyWith(selectedTodoIds: selected);
  }

  void clearSelection() {
    state = state.copyWith(selectedTodoIds: {});
  }

  Future<void> deleteSelectedTodos() async {
    if (state.selectedTodoIds.isEmpty) return;

    final idsToDelete = Set<String>.from(state.selectedTodoIds);

    final remaining = state.todos
        .where((t) => !idsToDelete.contains(t.id))
        .toList();

    state = state.copyWith(
      todos: remaining,
      selectedTodoIds: {},
    );

    await _storage.deleteTodos(idsToDelete);
  }

  void toggleDarkMode() {
    final next = !state.isDarkMode;
    state = state.copyWith(isDarkMode: next);

    _storage.saveSettings(
      isDarkMode: next,
      asksForDeletionConfirmation: state.asksForDeletionConfirmation,
    );
  }

  void toggleDeletionConfirmation() {
    final next = !state.asksForDeletionConfirmation;
    state = state.copyWith(asksForDeletionConfirmation: next);

    _storage.saveSettings(
      isDarkMode: state.isDarkMode,
      asksForDeletionConfirmation: next,
    );
  }
}

final todosProvider = Provider<List<Todo>>((ref) {
  return ref.watch(appStateProvider).todos;
});

final isDarkModeProvider = Provider<bool>((ref) {
  return ref.watch(appStateProvider).isDarkMode;
});

final selectedTodosProvider = Provider<Set<String>>((ref) {
  return ref.watch(appStateProvider).selectedTodoIds;
});

final hasSelectedTodosProvider = Provider<bool>((ref) {
  return ref.watch(selectedTodosProvider).isNotEmpty;
});

final asksForDeletionConfirmationProvider = Provider<bool>((ref) {
  return ref.watch(appStateProvider).asksForDeletionConfirmation;
});
