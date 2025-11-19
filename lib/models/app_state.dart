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

  Map<String, dynamic> toJson() {
    return {
      'todos': todos.map((t) => t.toJson()).toList(),
      'isDarkMode': isDarkMode,
      'asksForDeletionConfirmation': asksForDeletionConfirmation,
    };
  }

  factory AppState.fromJson(Map<String, dynamic> json) {
    return AppState(
      todos: (json['todos'] as List<dynamic>? ?? [])
          .map((item) => Todo.fromJson(item as Map<String, dynamic>))
          .toList(),
      isDarkMode: json['isDarkMode'] as bool? ?? false,
      asksForDeletionConfirmation:
          json['asksForDeletionConfirmation'] as bool? ?? true,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppState &&
        other.isDarkMode == isDarkMode &&
        other.asksForDeletionConfirmation == asksForDeletionConfirmation &&
        _listEquals(other.todos, todos) &&
        _setEquals(other.selectedTodoIds, selectedTodoIds);
  }

  @override
  int get hashCode => Object.hash(
    isDarkMode,
    asksForDeletionConfirmation,
    Object.hashAll(todos),
    Object.hashAll(selectedTodoIds),
  );

  static bool _listEquals(List<Todo> a, List<Todo> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  static bool _setEquals(Set<String> a, Set<String> b) {
    if (a.length != b.length) return false;
    for (final v in a) {
      if (!b.contains(v)) return false;
    }
    return true;
  }
}
