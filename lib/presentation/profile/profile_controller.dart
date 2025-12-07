import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:lifepro_new/domain/entities/user_profile.dart';
import 'package:lifepro_new/presentation/profile/profile_state.dart';

class ProfileController extends StateNotifier<ProfileState> {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  ProfileController() : super(const ProfileState()) {
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      final profileJson = await _secureStorage.read(key: 'userProfile');
      if (profileJson != null) {
        final profile = UserProfile.fromJson(json.decode(profileJson));
        state = state.copyWith(userProfile: profile);
      } else {
        // Default mock data if none saved
        final mockProfile = UserProfile(
          fullName: '',
          email: '',
          phoneWithCountryCode: '',
          dob: null,
          gender: null,
          emailVerified: false,
          phoneVerified: false,
        );
        state = state.copyWith(userProfile: mockProfile);
      }
    } catch (e) {
      print('Error loading profile: $e');
      // Fallback
      final mockProfile = UserProfile(
        fullName: '',
        email: '',
        phoneWithCountryCode: '',
        dob: null,
        gender: null,
        emailVerified: false,
        phoneVerified: false,
      );
      state = state.copyWith(userProfile: mockProfile);
    }
  }

  void updateFullName(String fullName) {
    final newProfile = state.userProfile.copyWith(fullName: fullName);
    state = state.copyWith(userProfile: newProfile);
    _validateField('fullName');
  }

  void updateEmail(String email) {
    final newProfile = state.userProfile.copyWith(email: email, emailVerified: false);
    state = state.copyWith(userProfile: newProfile);
    _validateField('email');
  }

  void updatePhone(String phone) {
    final newProfile = state.userProfile.copyWith(phoneWithCountryCode: phone, phoneVerified: false);
    state = state.copyWith(userProfile: newProfile);
    _validateField('phone');
    // Trigger OTP if valid phone
    if (_isValidPhone(phone) && !newProfile.phoneVerified) {
      state = state.copyWith(showOtpDialog: true);
    }
  }

  void updateDob(DateTime dob) {
    final now = DateTime.now();
    if (dob.isAfter(now)) return;
    final age = now.year - dob.year - (now.month > dob.month || (now.month == dob.month && now.day >= dob.day) ? 0 : 1);
    if (age < 0) return;
    final newProfile = state.userProfile.copyWith(dob: dob);
    state = state.copyWith(userProfile: newProfile);
    _validateField('dob');
  }

  void updateGender(Gender gender) {
    final newProfile = state.userProfile.copyWith(gender: gender);
    state = state.copyWith(userProfile: newProfile);
    _validateField('gender');
  }

  void _validateField(String field) {
    final errors = Map<String, String>.from(state.fieldErrors ?? {});
    switch (field) {
      case 'fullName':
        if (state.userProfile.fullName.isEmpty) {
          errors['fullName'] = 'Please enter your full name.';
        } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(state.userProfile.fullName)) {
          errors['fullName'] = 'Full name must not include special characters.';
        } else if (state.userProfile.fullName.split(' ').where((w) => w.isNotEmpty).length < 2) {
          errors['fullName'] = 'Please enter full name with at least first and last name.';
        } else {
          errors.remove('fullName');
        }
        break;
      case 'email':
        if (state.userProfile.email.isEmpty) {
          errors['email'] = 'Please enter your email.';
        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(state.userProfile.email)) {
          errors['email'] = 'Please enter a valid email address.';
        } else {
          errors.remove('email');
        }
        break;
      case 'phone':
        if (state.userProfile.phoneWithCountryCode.isEmpty) {
          errors['phone'] = 'Please enter your phone number with country code.';
        } else if (!RegExp(r'^\+[0-9]{1,4}\s[0-9]{6,14}$').hasMatch(state.userProfile.phoneWithCountryCode)) {
          errors['phone'] = 'Please enter a valid phone number with country code (e.g., +91 9876543210).';
        } else {
          errors.remove('phone');
        }
        break;
      case 'dob':
        if (state.userProfile.dob == null) {
          errors['dob'] = 'Please select your date of birth.';
        } else {
          final age = _calculateAge(state.userProfile.dob!);
          if (age <= 0) {
            errors['dob'] = 'Invalid date of birth.';
          } else {
            errors.remove('dob');
          }
        }
        break;
      case 'gender':
        if (state.userProfile.gender == null) {
          errors['gender'] = 'Please select your gender.';
        } else {
          errors.remove('gender');
        }
        break;
    }
    state = state.copyWith(fieldErrors: errors);
  }

  bool _isValidPhone(String phone) {
    return RegExp(r'^\+[0-9]{1,4}\s[0-9]{6,14}$').hasMatch(phone);
  }

  int _calculateAge(DateTime dob) {
    final now = DateTime.now();
    int age = now.year - dob.year;
    if (now.month < dob.month || (now.month == dob.month && now.day < dob.day)) {
      age--;
    }
    return age;
  }

  bool get isFormValid {
    return (state.fieldErrors?.isEmpty ?? true) &&
           state.userProfile.fullName.isNotEmpty &&
           state.userProfile.email.isNotEmpty &&
           state.userProfile.phoneWithCountryCode.isNotEmpty &&
           state.userProfile.dob != null &&
           state.userProfile.gender != null;
  }

  void verifyOtp(String otp) {
    // Mock OTP verification
    if (otp == '123456') { // dummy
      final newProfile = state.userProfile.copyWith(phoneVerified: true);
      state = state.copyWith(userProfile: newProfile, showOtpDialog: false, otpInput: null);
    } else {
      state = state.copyWith(errorMessage: 'Invalid OTP. Try 123456 for demo.');
    }
  }

  void verifyEmail() {
    // Mock email verification
    final newProfile = state.userProfile.copyWith(emailVerified: true);
    state = state.copyWith(userProfile: newProfile, showEmailVerificationDialog: false);
  }

  Future<void> saveProfile() async {
    if (!isFormValid) return;
    state = state.copyWith(isSaving: true);

    try {
      // Sanitize inputs
      final sanitizedProfile = state.userProfile.copyWith(
        fullName: _sanitizeText(state.userProfile.fullName),
        email: _sanitizeEmail(state.userProfile.email),
        phoneWithCountryCode: _sanitizePhone(state.userProfile.phoneWithCountryCode),
      );

      // Save to secure storage
      await _secureStorage.write(
        key: 'userProfile',
        value: json.encode(sanitizedProfile.toJson()),
      );

      // Update state with sanitized profile
      state = state.copyWith(userProfile: sanitizedProfile);

      // Show email verification if not verified
      if (!sanitizedProfile.emailVerified) {
        state = state.copyWith(showEmailVerificationDialog: true, isSaving: false);
      } else {
        state = state.copyWith(isSaving: false, profileSaved: true);
        Future.delayed(const Duration(seconds: 2), () {
          state = state.copyWith(profileSaved: false);
        });
      }
    } catch (e) {
      state = state.copyWith(isSaving: false, errorMessage: e.toString());
    }
  }

  String _sanitizeText(String text) {
    // Allow only letters and spaces
    return text.replaceAll(RegExp(r'[^a-zA-Z\s]'), '').trim();
  }

  String _sanitizeEmail(String email) {
    // Basic sanitize, trim and lowercase
    return email.trim().toLowerCase();
  }

  String _sanitizePhone(String phone) {
    // Allow only + and numbers and spaces
    return phone.replaceAll(RegExp(r'[^\+\d\s]'), '').trim();
  }

  void closeOtpDialog() {
    state = state.copyWith(showOtpDialog: false, otpInput: null);
  }

  void closeEmailDialog() {
    state = state.copyWith(showEmailVerificationDialog: false);
  }

  void dismissSuccess() {
    state = state.copyWith(profileSaved: false);
  }

  // Calculate age for display
  String get ageDisplay {
    if (state.userProfile.dob == null) return '';
    final age = _calculateAge(state.userProfile.dob!);
    return 'Age: $age years';
  }

  // Format dob for display
  String get dobFormatted {
    if (state.userProfile.dob == null) return '';
    return DateFormat('yyyy-MM-dd').format(state.userProfile.dob!);
  }
}

final profileControllerProvider = StateNotifierProvider<ProfileController, ProfileState>(
  (ref) => ProfileController(),
);
