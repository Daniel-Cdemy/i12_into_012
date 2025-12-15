import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i12_into_012/models/app_state.dart';
import 'package:i12_into_012/models/todo.dart';
import 'package:i12_into_012/providers/local_json_provider.dart';
import 'package:i12_into_012/services/storage_service.dart';
import 'package:uuid/uuid.dart';

final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService();
});

final appStateProvider = NotifierProvider<LocalJsonNotifier, AppState>(
  LocalJsonNotifier.new,
);

class LocalJsonNotifier extends AppStateNotifier {
  late final StorageService _storageService;
  final Uuid _uuid = const Uuid();

  @override
  AppState build() {
    _storageService = ref.read(storageServiceProvider);

    loadState();

    return const AppState();
  }

  Future<void> loadState() async {
    final loaded = await _storageService.loadAppState();
    if (loaded != null) {
      state = loaded;
    }
  }

  Future<void> saveState() async {
    await _storageService.saveAppState(state);
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
    saveState();
  }

  void toggleTodo(String id) {
    final updated = state.todos
        .map(
          (t) => t.id == id ? t.copyWith(isCompleted: !t.isCompleted) : t,
        )
        .toList();

    state = state.copyWith(todos: updated);
    saveState();
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

    final remaining = state.todos
        .where((t) => !state.selectedTodoIds.contains(t.id))
        .toList();

    state = state.copyWith(
      todos: remaining,
      selectedTodoIds: {},
    );
    saveState();
  }

  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
    saveState();
  }

  void toggleDeletionConfirmation() {
    state = state.copyWith(
      asksForDeletionConfirmation: !state.asksForDeletionConfirmation,
    );
    saveState();
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
