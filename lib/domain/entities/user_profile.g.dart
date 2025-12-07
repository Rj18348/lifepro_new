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
    };

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
  Gender.other: 'other',
  Gender.preferNotToSay: 'prefer_not_to_say',
};
