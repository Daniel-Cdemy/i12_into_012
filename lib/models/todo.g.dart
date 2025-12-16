// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoImpl _$$TodoImplFromJson(Map<String, dynamic> json) => _$TodoImpl(
  id: json['id'] as String,
  text: json['text'] as String,
  isCompleted: json['isCompleted'] as bool? ?? false,
);

Map<String, dynamic> _$$TodoImplToJson(_$TodoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'isCompleted': instance.isCompleted,
    };
