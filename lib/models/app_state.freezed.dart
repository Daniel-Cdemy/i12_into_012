// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AppState _$AppStateFromJson(Map<String, dynamic> json) {
  return _AppState.fromJson(json);
}

/// @nodoc
mixin _$AppState {
  List<Todo> get todos => throw _privateConstructorUsedError;
  bool get isDarkMode => throw _privateConstructorUsedError;
  bool get asksForDeletionConfirmation => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Set<String> get selectedTodoIds => throw _privateConstructorUsedError;

  /// Serializes this AppState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppStateCopyWith<AppState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) then) =
      _$AppStateCopyWithImpl<$Res, AppState>;
  @useResult
  $Res call({
    List<Todo> todos,
    bool isDarkMode,
    bool asksForDeletionConfirmation,
    @JsonKey(includeFromJson: false, includeToJson: false)
    Set<String> selectedTodoIds,
  });
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res, $Val extends AppState>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? todos = null,
    Object? isDarkMode = null,
    Object? asksForDeletionConfirmation = null,
    Object? selectedTodoIds = null,
  }) {
    return _then(
      _value.copyWith(
            todos: null == todos
                ? _value.todos
                : todos // ignore: cast_nullable_to_non_nullable
                      as List<Todo>,
            isDarkMode: null == isDarkMode
                ? _value.isDarkMode
                : isDarkMode // ignore: cast_nullable_to_non_nullable
                      as bool,
            asksForDeletionConfirmation: null == asksForDeletionConfirmation
                ? _value.asksForDeletionConfirmation
                : asksForDeletionConfirmation // ignore: cast_nullable_to_non_nullable
                      as bool,
            selectedTodoIds: null == selectedTodoIds
                ? _value.selectedTodoIds
                : selectedTodoIds // ignore: cast_nullable_to_non_nullable
                      as Set<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AppStateImplCopyWith<$Res>
    implements $AppStateCopyWith<$Res> {
  factory _$$AppStateImplCopyWith(
    _$AppStateImpl value,
    $Res Function(_$AppStateImpl) then,
  ) = __$$AppStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Todo> todos,
    bool isDarkMode,
    bool asksForDeletionConfirmation,
    @JsonKey(includeFromJson: false, includeToJson: false)
    Set<String> selectedTodoIds,
  });
}

/// @nodoc
class __$$AppStateImplCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$AppStateImpl>
    implements _$$AppStateImplCopyWith<$Res> {
  __$$AppStateImplCopyWithImpl(
    _$AppStateImpl _value,
    $Res Function(_$AppStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? todos = null,
    Object? isDarkMode = null,
    Object? asksForDeletionConfirmation = null,
    Object? selectedTodoIds = null,
  }) {
    return _then(
      _$AppStateImpl(
        todos: null == todos
            ? _value._todos
            : todos // ignore: cast_nullable_to_non_nullable
                  as List<Todo>,
        isDarkMode: null == isDarkMode
            ? _value.isDarkMode
            : isDarkMode // ignore: cast_nullable_to_non_nullable
                  as bool,
        asksForDeletionConfirmation: null == asksForDeletionConfirmation
            ? _value.asksForDeletionConfirmation
            : asksForDeletionConfirmation // ignore: cast_nullable_to_non_nullable
                  as bool,
        selectedTodoIds: null == selectedTodoIds
            ? _value._selectedTodoIds
            : selectedTodoIds // ignore: cast_nullable_to_non_nullable
                  as Set<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AppStateImpl implements _AppState {
  const _$AppStateImpl({
    final List<Todo> todos = const [],
    this.isDarkMode = false,
    this.asksForDeletionConfirmation = true,
    @JsonKey(includeFromJson: false, includeToJson: false)
    final Set<String> selectedTodoIds = const <String>{},
  }) : _todos = todos,
       _selectedTodoIds = selectedTodoIds;

  factory _$AppStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppStateImplFromJson(json);

  final List<Todo> _todos;
  @override
  @JsonKey()
  List<Todo> get todos {
    if (_todos is EqualUnmodifiableListView) return _todos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_todos);
  }

  @override
  @JsonKey()
  final bool isDarkMode;
  @override
  @JsonKey()
  final bool asksForDeletionConfirmation;
  final Set<String> _selectedTodoIds;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Set<String> get selectedTodoIds {
    if (_selectedTodoIds is EqualUnmodifiableSetView) return _selectedTodoIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_selectedTodoIds);
  }

  @override
  String toString() {
    return 'AppState(todos: $todos, isDarkMode: $isDarkMode, asksForDeletionConfirmation: $asksForDeletionConfirmation, selectedTodoIds: $selectedTodoIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppStateImpl &&
            const DeepCollectionEquality().equals(other._todos, _todos) &&
            (identical(other.isDarkMode, isDarkMode) ||
                other.isDarkMode == isDarkMode) &&
            (identical(
                  other.asksForDeletionConfirmation,
                  asksForDeletionConfirmation,
                ) ||
                other.asksForDeletionConfirmation ==
                    asksForDeletionConfirmation) &&
            const DeepCollectionEquality().equals(
              other._selectedTodoIds,
              _selectedTodoIds,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_todos),
    isDarkMode,
    asksForDeletionConfirmation,
    const DeepCollectionEquality().hash(_selectedTodoIds),
  );

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppStateImplCopyWith<_$AppStateImpl> get copyWith =>
      __$$AppStateImplCopyWithImpl<_$AppStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppStateImplToJson(this);
  }
}

abstract class _AppState implements AppState {
  const factory _AppState({
    final List<Todo> todos,
    final bool isDarkMode,
    final bool asksForDeletionConfirmation,
    @JsonKey(includeFromJson: false, includeToJson: false)
    final Set<String> selectedTodoIds,
  }) = _$AppStateImpl;

  factory _AppState.fromJson(Map<String, dynamic> json) =
      _$AppStateImpl.fromJson;

  @override
  List<Todo> get todos;
  @override
  bool get isDarkMode;
  @override
  bool get asksForDeletionConfirmation;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Set<String> get selectedTodoIds;

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppStateImplCopyWith<_$AppStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
