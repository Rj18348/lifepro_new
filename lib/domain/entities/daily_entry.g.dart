// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyEntryImpl _$$DailyEntryImplFromJson(Map<String, dynamic> json) =>
    _$DailyEntryImpl(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      moodScore: (json['moodScore'] as num).toInt(),
      note: json['note'] as String?,
      aiGenerated: json['aiGenerated'] as bool? ?? false,
      aiSummary: json['aiSummary'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
    );

Map<String, dynamic> _$$DailyEntryImplToJson(_$DailyEntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'moodScore': instance.moodScore,
      'note': instance.note,
      'aiGenerated': instance.aiGenerated,
      'aiSummary': instance.aiSummary,
      'tags': instance.tags,
    };
