import 'package:freezed_annotation/freezed_annotation.dart';

part 'emergency_contact.freezed.dart';
part 'emergency_contact.g.dart';

@freezed
class EmergencyContact with _$EmergencyContact {
  const factory EmergencyContact({
    required String name,
    required String phone,
    required String relation,
  }) = _EmergencyContact;

  factory EmergencyContact.fromJson(Map<String, dynamic> json) =>
      _$EmergencyContactFromJson(json);
}
