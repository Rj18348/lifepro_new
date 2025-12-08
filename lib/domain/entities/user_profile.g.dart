// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      fullName: json['fullName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phoneWithCountryCode: json['phoneWithCountryCode'] as String? ?? '',
      dob: json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
      gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
      emailVerified: json['emailVerified'] as bool? ?? false,
      phoneVerified: json['phoneVerified'] as bool? ?? false,
      profilePictureUrl: json['profilePictureUrl'] as String?,
      nickname: json['nickname'] as String? ?? '',
      bio: json['bio'] as String? ?? '',
      occupation: json['occupation'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      timezone: json['timezone'] as String?,
      emergencyContacts:
          (json['emergencyContacts'] as List<dynamic>?)
              ?.map((e) => EmergencyContact.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      autoShareLocation: json['autoShareLocation'] as bool? ?? false,
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'email': instance.email,
      'phoneWithCountryCode': instance.phoneWithCountryCode,
      'dob': instance.dob?.toIso8601String(),
      'gender': _$GenderEnumMap[instance.gender],
      'emailVerified': instance.emailVerified,
      'phoneVerified': instance.phoneVerified,
      'profilePictureUrl': instance.profilePictureUrl,
      'nickname': instance.nickname,
      'bio': instance.bio,
      'occupation': instance.occupation,
      'country': instance.country,
      'city': instance.city,
      'timezone': instance.timezone,
      'emergencyContacts': instance.emergencyContacts,
      'autoShareLocation': instance.autoShareLocation,
    };

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
  Gender.other: 'other',
  Gender.preferNotToSay: 'prefer_not_to_say',
};
