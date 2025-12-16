import 'package:freezed_annotation/freezed_annotation.dart';
import 'todo.dart';

part 'app_state.freezed.dart';
part 'app_state.g.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    @Default([]) List<Todo> todos,
    @Default(false) bool isDarkMode,
    @Default(true) bool asksForDeletionConfirmation,

    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(<String>{})
    Set<String> selectedTodoIds,
  }) = _AppState;

  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);
}
