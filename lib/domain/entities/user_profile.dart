import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lifepro_new/domain/entities/emergency_contact.dart';

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
    // Phase 1: Extended profile information
    String? profilePictureUrl,
    @Default('') String nickname,
    @Default('') String bio,
    String? occupation,
    String? country,
    String? city,
    String? timezone,
    // SOS Feature
    @Default([]) List<EmergencyContact> emergencyContacts,
    @Default(false) bool autoShareLocation,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}
