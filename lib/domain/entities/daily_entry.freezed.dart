// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DailyEntry _$DailyEntryFromJson(Map<String, dynamic> json) {
  return _DailyEntry.fromJson(json);
}

/// @nodoc
mixin _$DailyEntry {
  String get id => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  int get moodScore => throw _privateConstructorUsedError; // 1-10
  String? get note => throw _privateConstructorUsedError;
  bool get aiGenerated => throw _privateConstructorUsedError;
  String? get aiSummary => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;

  /// Serializes this DailyEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyEntryCopyWith<DailyEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyEntryCopyWith<$Res> {
  factory $DailyEntryCopyWith(
    DailyEntry value,
    $Res Function(DailyEntry) then,
  ) = _$DailyEntryCopyWithImpl<$Res, DailyEntry>;
  @useResult
  $Res call({
    String id,
    DateTime date,
    int moodScore,
    String? note,
    bool aiGenerated,
    String? aiSummary,
    List<String> tags,
  });
}

/// @nodoc
class _$DailyEntryCopyWithImpl<$Res, $Val extends DailyEntry>
    implements $DailyEntryCopyWith<$Res> {
  _$DailyEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? moodScore = null,
    Object? note = freezed,
    Object? aiGenerated = null,
    Object? aiSummary = freezed,
    Object? tags = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            moodScore: null == moodScore
                ? _value.moodScore
                : moodScore // ignore: cast_nullable_to_non_nullable
                      as int,
            note: freezed == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                      as String?,
            aiGenerated: null == aiGenerated
                ? _value.aiGenerated
                : aiGenerated // ignore: cast_nullable_to_non_nullable
                      as bool,
            aiSummary: freezed == aiSummary
                ? _value.aiSummary
                : aiSummary // ignore: cast_nullable_to_non_nullable
                      as String?,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DailyEntryImplCopyWith<$Res>
    implements $DailyEntryCopyWith<$Res> {
  factory _$$DailyEntryImplCopyWith(
    _$DailyEntryImpl value,
    $Res Function(_$DailyEntryImpl) then,
  ) = __$$DailyEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    DateTime date,
    int moodScore,
    String? note,
    bool aiGenerated,
    String? aiSummary,
    List<String> tags,
  });
}

/// @nodoc
class __$$DailyEntryImplCopyWithImpl<$Res>
    extends _$DailyEntryCopyWithImpl<$Res, _$DailyEntryImpl>
    implements _$$DailyEntryImplCopyWith<$Res> {
  __$$DailyEntryImplCopyWithImpl(
    _$DailyEntryImpl _value,
    $Res Function(_$DailyEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DailyEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? moodScore = null,
    Object? note = freezed,
    Object? aiGenerated = null,
    Object? aiSummary = freezed,
    Object? tags = null,
  }) {
    return _then(
      _$DailyEntryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        moodScore: null == moodScore
            ? _value.moodScore
            : moodScore // ignore: cast_nullable_to_non_nullable
                  as int,
        note: freezed == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String?,
        aiGenerated: null == aiGenerated
            ? _value.aiGenerated
            : aiGenerated // ignore: cast_nullable_to_non_nullable
                  as bool,
        aiSummary: freezed == aiSummary
            ? _value.aiSummary
            : aiSummary // ignore: cast_nullable_to_non_nullable
                  as String?,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyEntryImpl implements _DailyEntry {
  const _$DailyEntryImpl({
    required this.id,
    required this.date,
    required this.moodScore,
    this.note,
    this.aiGenerated = false,
    this.aiSummary,
    final List<String> tags = const [],
  }) : _tags = tags;

  factory _$DailyEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyEntryImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime date;
  @override
  final int moodScore;
  // 1-10
  @override
  final String? note;
  @override
  @JsonKey()
  final bool aiGenerated;
  @override
  final String? aiSummary;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  String toString() {
    return 'DailyEntry(id: $id, date: $date, moodScore: $moodScore, note: $note, aiGenerated: $aiGenerated, aiSummary: $aiSummary, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.moodScore, moodScore) ||
                other.moodScore == moodScore) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.aiGenerated, aiGenerated) ||
                other.aiGenerated == aiGenerated) &&
            (identical(other.aiSummary, aiSummary) ||
                other.aiSummary == aiSummary) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    date,
    moodScore,
    note,
    aiGenerated,
    aiSummary,
    const DeepCollectionEquality().hash(_tags),
  );

  /// Create a copy of DailyEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyEntryImplCopyWith<_$DailyEntryImpl> get copyWith =>
      __$$DailyEntryImplCopyWithImpl<_$DailyEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyEntryImplToJson(this);
  }
}

abstract class _DailyEntry implements DailyEntry {
  const factory _DailyEntry({
    required final String id,
    required final DateTime date,
    required final int moodScore,
    final String? note,
    final bool aiGenerated,
    final String? aiSummary,
    final List<String> tags,
  }) = _$DailyEntryImpl;

  factory _DailyEntry.fromJson(Map<String, dynamic> json) =
      _$DailyEntryImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get date;
  @override
  int get moodScore; // 1-10
  @override
  String? get note;
  @override
  bool get aiGenerated;
  @override
  String? get aiSummary;
  @override
  List<String> get tags;

  /// Create a copy of DailyEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyEntryImplCopyWith<_$DailyEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
