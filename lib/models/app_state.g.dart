// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppStateImpl _$$AppStateImplFromJson(Map<String, dynamic> json) =>
    _$AppStateImpl(
      todos:
          (json['todos'] as List<dynamic>?)
              ?.map((e) => Todo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isDarkMode: json['isDarkMode'] as bool? ?? false,
      asksForDeletionConfirmation:
          json['asksForDeletionConfirmation'] as bool? ?? true,
    );

Map<String, dynamic> _$$AppStateImplToJson(_$AppStateImpl instance) =>
    <String, dynamic>{
      'todos': instance.todos,
      'isDarkMode': instance.isDarkMode,
      'asksForDeletionConfirmation': instance.asksForDeletionConfirmation,
    };
