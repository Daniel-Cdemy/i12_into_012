import 'package:i12_into_012/models/todo.dart';

class AppState {
  final List<Todo> todos;
  final bool isDarkMode;
  final bool asksForDeletionConfirmation;
  final Set<String> selectedTodoIds;

  const AppState({
    this.todos = const [],
    this.isDarkMode = false,
    this.asksForDeletionConfirmation = true,
    this.selectedTodoIds = const {},
  });

  AppState copyWith({
    List<Todo>? todos,
    bool? isDarkMode,
    bool? asksForDeletionConfirmation,
    Set<String>? selectedTodoIds,
  }) {
    return AppState(
      todos: todos ?? this.todos,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      asksForDeletionConfirmation:
          asksForDeletionConfirmation ?? this.asksForDeletionConfirmation,
      selectedTodoIds: selectedTodoIds ?? this.selectedTodoIds,
    );
  }

  Map<String, dynamic> toJson() => {
    'todos': todos.map((t) => t.toJson()).toList(),
    'isDarkMode': isDarkMode,
    'asksForDeletionConfirmation': asksForDeletionConfirmation,
  };

  factory AppState.fromJson(Map<String, dynamic> json) {
    final todosList = (json['todos'] as List<dynamic>? ?? [])
        .map((e) => Todo.fromJson(e as Map<String, dynamic>))
        .toList();

    return AppState(
      todos: todosList,
      isDarkMode: (json['isDarkMode'] as bool?) ?? false,
      asksForDeletionConfirmation:
          (json['asksForDeletionConfirmation'] as bool?) ?? true,
      selectedTodoIds: const {},
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          _listEquals(todos, other.todos) &&
          isDarkMode == other.isDarkMode &&
          asksForDeletionConfirmation == other.asksForDeletionConfirmation &&
          _setEquals(selectedTodoIds, other.selectedTodoIds);

  @override
  int get hashCode => Object.hash(
    Object.hashAll(todos),
    isDarkMode,
    asksForDeletionConfirmation,
    Object.hashAll(selectedTodoIds),
  );
}

bool _listEquals<T>(List<T> a, List<T> b) {
  if (identical(a, b)) return true;
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

bool _setEquals<T>(Set<T> a, Set<T> b) {
  if (identical(a, b)) return true;
  if (a.length != b.length) return false;
  for (final v in a) {
    if (!b.contains(v)) return false;
  }
  return true;
}
