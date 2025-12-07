// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ProfileState {
  UserProfile get userProfile => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isSaving => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  Map<String, String>? get fieldErrors => throw _privateConstructorUsedError;
  bool get showOtpDialog => throw _privateConstructorUsedError;
  String? get otpInput => throw _privateConstructorUsedError;
  bool get showEmailVerificationDialog => throw _privateConstructorUsedError;
  bool get profileSaved => throw _privateConstructorUsedError;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileStateCopyWith<ProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileStateCopyWith<$Res> {
  factory $ProfileStateCopyWith(
    ProfileState value,
    $Res Function(ProfileState) then,
  ) = _$ProfileStateCopyWithImpl<$Res, ProfileState>;
  @useResult
  $Res call({
    UserProfile userProfile,
    bool isLoading,
    bool isSaving,
    String? errorMessage,
    Map<String, String>? fieldErrors,
    bool showOtpDialog,
    String? otpInput,
    bool showEmailVerificationDialog,
    bool profileSaved,
  });

  $UserProfileCopyWith<$Res> get userProfile;
}

/// @nodoc
class _$ProfileStateCopyWithImpl<$Res, $Val extends ProfileState>
    implements $ProfileStateCopyWith<$Res> {
  _$ProfileStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userProfile = null,
    Object? isLoading = null,
    Object? isSaving = null,
    Object? errorMessage = freezed,
    Object? fieldErrors = freezed,
    Object? showOtpDialog = null,
    Object? otpInput = freezed,
    Object? showEmailVerificationDialog = null,
    Object? profileSaved = null,
  }) {
    return _then(
      _value.copyWith(
            userProfile: null == userProfile
                ? _value.userProfile
                : userProfile // ignore: cast_nullable_to_non_nullable
                      as UserProfile,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isSaving: null == isSaving
                ? _value.isSaving
                : isSaving // ignore: cast_nullable_to_non_nullable
                      as bool,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            fieldErrors: freezed == fieldErrors
                ? _value.fieldErrors
                : fieldErrors // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>?,
            showOtpDialog: null == showOtpDialog
                ? _value.showOtpDialog
                : showOtpDialog // ignore: cast_nullable_to_non_nullable
                      as bool,
            otpInput: freezed == otpInput
                ? _value.otpInput
                : otpInput // ignore: cast_nullable_to_non_nullable
                      as String?,
            showEmailVerificationDialog: null == showEmailVerificationDialog
                ? _value.showEmailVerificationDialog
                : showEmailVerificationDialog // ignore: cast_nullable_to_non_nullable
                      as bool,
            profileSaved: null == profileSaved
                ? _value.profileSaved
                : profileSaved // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserProfileCopyWith<$Res> get userProfile {
    return $UserProfileCopyWith<$Res>(_value.userProfile, (value) {
      return _then(_value.copyWith(userProfile: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProfileStateImplCopyWith<$Res>
    implements $ProfileStateCopyWith<$Res> {
  factory _$$ProfileStateImplCopyWith(
    _$ProfileStateImpl value,
    $Res Function(_$ProfileStateImpl) then,
  ) = __$$ProfileStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    UserProfile userProfile,
    bool isLoading,
    bool isSaving,
    String? errorMessage,
    Map<String, String>? fieldErrors,
    bool showOtpDialog,
    String? otpInput,
    bool showEmailVerificationDialog,
    bool profileSaved,
  });

  @override
  $UserProfileCopyWith<$Res> get userProfile;
}

/// @nodoc
class __$$ProfileStateImplCopyWithImpl<$Res>
    extends _$ProfileStateCopyWithImpl<$Res, _$ProfileStateImpl>
    implements _$$ProfileStateImplCopyWith<$Res> {
  __$$ProfileStateImplCopyWithImpl(
    _$ProfileStateImpl _value,
    $Res Function(_$ProfileStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userProfile = null,
    Object? isLoading = null,
    Object? isSaving = null,
    Object? errorMessage = freezed,
    Object? fieldErrors = freezed,
    Object? showOtpDialog = null,
    Object? otpInput = freezed,
    Object? showEmailVerificationDialog = null,
    Object? profileSaved = null,
  }) {
    return _then(
      _$ProfileStateImpl(
        userProfile: null == userProfile
            ? _value.userProfile
            : userProfile // ignore: cast_nullable_to_non_nullable
                  as UserProfile,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSaving: null == isSaving
            ? _value.isSaving
            : isSaving // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        fieldErrors: freezed == fieldErrors
            ? _value._fieldErrors
            : fieldErrors // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>?,
        showOtpDialog: null == showOtpDialog
            ? _value.showOtpDialog
            : showOtpDialog // ignore: cast_nullable_to_non_nullable
                  as bool,
        otpInput: freezed == otpInput
            ? _value.otpInput
            : otpInput // ignore: cast_nullable_to_non_nullable
                  as String?,
        showEmailVerificationDialog: null == showEmailVerificationDialog
            ? _value.showEmailVerificationDialog
            : showEmailVerificationDialog // ignore: cast_nullable_to_non_nullable
                  as bool,
        profileSaved: null == profileSaved
            ? _value.profileSaved
            : profileSaved // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$ProfileStateImpl implements _ProfileState {
  const _$ProfileStateImpl({
    this.userProfile = const UserProfile(),
    this.isLoading = false,
    this.isSaving = false,
    this.errorMessage,
    final Map<String, String>? fieldErrors,
    this.showOtpDialog = false,
    this.otpInput,
    this.showEmailVerificationDialog = false,
    this.profileSaved = false,
  }) : _fieldErrors = fieldErrors;

  @override
  @JsonKey()
  final UserProfile userProfile;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isSaving;
  @override
  final String? errorMessage;
  final Map<String, String>? _fieldErrors;
  @override
  Map<String, String>? get fieldErrors {
    final value = _fieldErrors;
    if (value == null) return null;
    if (_fieldErrors is EqualUnmodifiableMapView) return _fieldErrors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey()
  final bool showOtpDialog;
  @override
  final String? otpInput;
  @override
  @JsonKey()
  final bool showEmailVerificationDialog;
  @override
  @JsonKey()
  final bool profileSaved;

  @override
  String toString() {
    return 'ProfileState(userProfile: $userProfile, isLoading: $isLoading, isSaving: $isSaving, errorMessage: $errorMessage, fieldErrors: $fieldErrors, showOtpDialog: $showOtpDialog, otpInput: $otpInput, showEmailVerificationDialog: $showEmailVerificationDialog, profileSaved: $profileSaved)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileStateImpl &&
            (identical(other.userProfile, userProfile) ||
                other.userProfile == userProfile) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isSaving, isSaving) ||
                other.isSaving == isSaving) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality().equals(
              other._fieldErrors,
              _fieldErrors,
            ) &&
            (identical(other.showOtpDialog, showOtpDialog) ||
                other.showOtpDialog == showOtpDialog) &&
            (identical(other.otpInput, otpInput) ||
                other.otpInput == otpInput) &&
            (identical(
                  other.showEmailVerificationDialog,
                  showEmailVerificationDialog,
                ) ||
                other.showEmailVerificationDialog ==
                    showEmailVerificationDialog) &&
            (identical(other.profileSaved, profileSaved) ||
                other.profileSaved == profileSaved));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    userProfile,
    isLoading,
    isSaving,
    errorMessage,
    const DeepCollectionEquality().hash(_fieldErrors),
    showOtpDialog,
    otpInput,
    showEmailVerificationDialog,
    profileSaved,
  );

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileStateImplCopyWith<_$ProfileStateImpl> get copyWith =>
      __$$ProfileStateImplCopyWithImpl<_$ProfileStateImpl>(this, _$identity);
}

abstract class _ProfileState implements ProfileState {
  const factory _ProfileState({
    final UserProfile userProfile,
    final bool isLoading,
    final bool isSaving,
    final String? errorMessage,
    final Map<String, String>? fieldErrors,
    final bool showOtpDialog,
    final String? otpInput,
    final bool showEmailVerificationDialog,
    final bool profileSaved,
  }) = _$ProfileStateImpl;

  @override
  UserProfile get userProfile;
  @override
  bool get isLoading;
  @override
  bool get isSaving;
  @override
  String? get errorMessage;
  @override
  Map<String, String>? get fieldErrors;
  @override
  bool get showOtpDialog;
  @override
  String? get otpInput;
  @override
  bool get showEmailVerificationDialog;
  @override
  bool get profileSaved;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileStateImplCopyWith<_$ProfileStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
