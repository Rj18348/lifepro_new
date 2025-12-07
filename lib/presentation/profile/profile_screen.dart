import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lifepro_new/domain/entities/user_profile.dart';
import 'package:lifepro_new/presentation/profile/profile_controller.dart';
import 'package:lifepro_new/presentation/profile/profile_state.dart';
import '../providers/theme_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileControllerProvider);
    final profileController = ref.read(profileControllerProvider.notifier);
    final themeMode = ref.watch(themeProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Basic Details Section
                Text(
                  "Basic Details",
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 16),
                _ProfileField(
                  label: 'Full Name',
                  icon: Icons.person,
                  controller: TextEditingController(text: profileState.userProfile.fullName),
                  errorText: profileState.fieldErrors?['fullName'],
                  hint: 'Enter your full name',
                  onChanged: profileController.updateFullName,
                  keyboardType: TextInputType.name,
                ),
                _ProfileField(
                  label: 'Email',
                  icon: Icons.email,
                  controller: TextEditingController(text: profileState.userProfile.email),
                  errorText: profileState.fieldErrors?['email'],
                  hint: 'Enter your email',
                  onChanged: profileController.updateEmail,
                  keyboardType: TextInputType.emailAddress,
                ),
                _ProfileField(
                  label: 'Phone Number',
                  icon: Icons.phone,
                  controller: TextEditingController(text: profileState.userProfile.phoneWithCountryCode),
                  errorText: profileState.fieldErrors?['phone'],
                  hint: '+91 9876543210',
                  onChanged: profileController.updatePhone,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 32),

                // Personal Section
                Text(
                  "Personal",
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 16),
                _DatePickerField(
                  label: 'Date of Birth',
                  icon: Icons.calendar_today,
                  selectedDate: profileState.userProfile.dob,
                  onChanged: profileController.updateDob,
                  ageText: profileController.ageDisplay,
                  errorText: profileState.fieldErrors?['dob'],
                ),
                _GenderDropdown(
                  label: 'Gender',
                  icon: Icons.wc,
                  selectedGender: profileState.userProfile.gender,
                  onChanged: profileController.updateGender,
                  errorText: profileState.fieldErrors?['gender'],
                ),
                const SizedBox(height: 40),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: profileController.isFormValid
                        ? profileController.saveProfile
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: profileState.isSaving
                        ? const CircularProgressIndicator()
                        : const Text('Save Profile'),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),

          // OTP Dialog
          if (profileState.showOtpDialog)
            _OtpDialog(
              onVerify: (otp) => profileController.verifyOtp(otp),
              onClose: profileController.closeOtpDialog,
              isLoading: false,
              error: profileState.errorMessage,
            ),

          // Email Verification Dialog
          if (profileState.showEmailVerificationDialog)
            _EmailVerificationDialog(
              onVerify: profileController.verifyEmail,
              onClose: profileController.closeEmailDialog,
            ),

          // Success Popup
          if (profileState.profileSaved)
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check, color: Colors.white),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Profile Updated Successfully',
                        style: textTheme.bodyMedium?.copyWith(color: Colors.white),
                      ),
                    ),
                    IconButton(
                      onPressed: profileController.dismissSuccess,
                      icon: const Icon(Icons.close, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ProfileField extends StatefulWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final String? errorText;
  final String hint;
  final Function(String) onChanged;
  final TextInputType keyboardType;

  const _ProfileField({
    required this.label,
    required this.icon,
    required this.controller,
    this.errorText,
    required this.hint,
    required this.onChanged,
    this.keyboardType = TextInputType.text,
  });

  @override
  _ProfileFieldState createState() => _ProfileFieldState();
}

class _ProfileFieldState extends State<_ProfileField> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hint,
          errorText: widget.errorText,
          prefixIcon: Icon(widget.icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: theme.colorScheme.surfaceContainerHighest,
        ),
        keyboardType: widget.keyboardType,
        onChanged: widget.onChanged,
      ),
    );
  }
}

class _DatePickerField extends StatelessWidget {
  final String label;
  final IconData icon;
  final DateTime? selectedDate;
  final Function(DateTime) onChanged;
  final String ageText;
  final String? errorText;

  const _DatePickerField({
    required this.label,
    required this.icon,
    this.selectedDate,
    required this.onChanged,
    required this.ageText,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            readOnly: true,
            decoration: InputDecoration(
              labelText: label,
              errorText: errorText,
              prefixIcon: Icon(icon),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: theme.colorScheme.surfaceContainerHighest,
              suffixIcon: const Icon(Icons.calendar_today),
            ),
            controller: TextEditingController(
              text: selectedDate != null ? DateFormat('yyyy-MM-dd').format(selectedDate!) : '',
            ),
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: selectedDate ?? DateTime.now().subtract(const Duration(days: 365*18)),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (picked != null) {
                onChanged(picked);
              }
            },
          ),
          if (ageText.isNotEmpty) Padding(
            padding: const EdgeInsets.only(left: 16, top: 4),
            child: Text(
              ageText,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GenderDropdown extends StatelessWidget {
  final String label;
  final IconData icon;
  final Gender? selectedGender;
  final Function(Gender) onChanged;
  final String? errorText;

  const _GenderDropdown({
    required this.label,
    required this.icon,
    this.selectedGender,
    required this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<Gender>(
        decoration: InputDecoration(
          labelText: label,
          errorText: errorText,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: theme.colorScheme.surfaceContainerHighest,
        ),
        value: selectedGender,
        items: Gender.values.map((gender) {
          return DropdownMenuItem(
            value: gender,
            child: Text(_genderDisplay(gender)),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) onChanged(value);
        },
      ),
    );
  }

  String _genderDisplay(Gender gender) {
    switch (gender) {
      case Gender.male:
        return 'Male';
      case Gender.female:
        return 'Female';
      case Gender.other:
        return 'Other';
      case Gender.preferNotToSay:
        return 'Prefer not to say';
    }
  }
}

class _OtpDialog extends StatefulWidget {
  final Function(String) onVerify;
  final VoidCallback onClose;
  final bool isLoading;
  final String? error;

  const _OtpDialog({
    required this.onVerify,
    required this.onClose,
    required this.isLoading,
    this.error,
  });

  @override
  _OtpDialogState createState() => _OtpDialogState();
}

class _OtpDialogState extends State<_OtpDialog> {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Enter OTP',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('An OTP has been sent to your phone for verification.'),
            const SizedBox(height: 16),
            TextField(
              controller: _otpController,
              decoration: const InputDecoration(
                labelText: 'OTP',
                hintText: 'Enter 6-digit OTP',
              ),
              keyboardType: TextInputType.number,
              maxLength: 6,
            ),
            if (widget.error != null) Text(widget.error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: widget.onClose,
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: widget.isLoading ? null : () => widget.onVerify(_otpController.text),
                  child: widget.isLoading ? const CircularProgressIndicator() : const Text('Verify'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }
}

class _EmailVerificationDialog extends StatelessWidget {
  final VoidCallback onVerify;
  final VoidCallback onClose;

  const _EmailVerificationDialog({
    required this.onVerify,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Verify Email',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('A verification email has been sent to your email address.'),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onClose,
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: onVerify,
                  child: const Text('Mark as Verified'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.colorScheme,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: colorScheme.primary),
          const SizedBox(height: 12),
          Text(
            value,
            style: textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          Text(
            label,
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? textColor;
  final Color? iconColor;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.textColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest.withValues(
            alpha: 0.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: iconColor ?? theme.colorScheme.onSurfaceVariant,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w500,
          color: textColor ?? theme.colorScheme.onSurface,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            )
          : null,
      trailing:
          trailing ??
          (onTap != null ? const Icon(Icons.chevron_right, size: 20) : null),
      onTap: onTap,
    );
  }
}
