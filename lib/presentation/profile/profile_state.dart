import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lifepro_new/domain/entities/user_profile.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(UserProfile()) UserProfile userProfile,
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    String? errorMessage,
    Map<String, String>? fieldErrors,
    @Default(false) bool showOtpDialog,
    String? otpInput,
    @Default(false) bool showEmailVerificationDialog,
    @Default(false) bool profileSaved, // to show success popup
  }) = _ProfileState;
}
