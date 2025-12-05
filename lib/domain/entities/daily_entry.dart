import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_entry.freezed.dart';
part 'daily_entry.g.dart';

@freezed
class DailyEntry with _$DailyEntry {
  const factory DailyEntry({
    required String id,
    required DateTime date,
    required int moodScore, // 1-10
    String? note,
    @Default(false) bool aiGenerated,
    String? aiSummary,
    @Default([]) List<String> tags,
  }) = _DailyEntry;

  factory DailyEntry.fromJson(Map<String, dynamic> json) => _$DailyEntryFromJson(json);
}
