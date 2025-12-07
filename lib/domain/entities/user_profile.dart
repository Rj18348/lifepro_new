import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

enum Gender {
  @JsonValue('male')
  male,
  @JsonValue('female')
  female,
  @JsonValue('other')
  other,
  @JsonValue('prefer_not_to_say')
  preferNotToSay,
}

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    @Default('') String fullName,
    @Default('') String email,
    @Default('') String phoneWithCountryCode,
    DateTime? dob,
    Gender? gender,
    @Default(false) bool emailVerified,
    @Default(false) bool phoneVerified,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}
