import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifepro_new/presentation/profile/profile_controller.dart';
import 'package:lifepro_new/presentation/providers/providers.dart';
import 'package:lifepro_new/presentation/settings/settings_screen.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  late TextEditingController fullNameController;
  late TextEditingController authEmailController;
  late TextEditingController phoneController;

  String? authEmail;

  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    final profileState = ref.read(profileControllerProvider);
    fullNameController = TextEditingController(text: profileState.userProfile.fullName);
    phoneController = TextEditingController(text: profileState.userProfile.phoneNumber);
    authEmailController = TextEditingController(text: 'Loading email...');
    loadAuthData();
  }

  Future<void> loadAuthData() async {
    final authService = ref.read(authServiceProvider);
    authEmail = await authService.getCurrentUserEmail();
    if (authEmail != null) {
      authEmailController.text = authEmail!;
    } else {
      authEmailController.text = 'No email available';
    }
    setState(() {}); // Update UI when auth data is loaded
  }

  @override
  void dispose() {
    fullNameController.dispose();
    authEmailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void toggleEditMode() {
    setState(() => isEditing = true);
  }

  void cancelEdit() {
    // Reset form values from controller
    final profileState = ref.read(profileControllerProvider);
    fullNameController.text = profileState.userProfile.fullName;
    authEmailController.text = authEmail ?? '';
    phoneController.text = profileState.userProfile.phoneNumber;

    setState(() => isEditing = false);
  }

  Future<void> saveProfile() async {
    final profileController = ref.read(profileControllerProvider.notifier);
    await profileController.saveProfile();
    setState(() => isEditing = false);
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileControllerProvider);
    final profileController = ref.read(profileControllerProvider.notifier);

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Profile' : 'Profile'),
        elevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        actions: [
          if (!isEditing)
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                );
              },
              icon: const Icon(Icons.settings),
              tooltip: 'Settings',
            ),
          if (!isEditing)
            TextButton.icon(
              onPressed: toggleEditMode,
              icon: const Icon(Icons.edit),
              label: const Text('Edit'),
              style: TextButton.styleFrom(
                foregroundColor: colorScheme.primary,
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Icon
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Welcome Text
                  if (!isEditing)
                    Column(
                      children: [
                        Text(
                          'Welcome to LifeBalance AI',
                          style: textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Manage your profile information',
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),

                  // Basic Details Section
                  if (isEditing)
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Edit Basic Details",
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                        ),
                      ),
                    )
                  else
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Your Information",
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),

                  _ProfileField(
                    label: 'Full Name',
                    icon: Icons.person,
                    controller: fullNameController,
                    errorText: profileState.fieldErrors?['fullName'],
                    hint: 'Enter your full name',
                    onChanged: profileController.updateFullName,
                    keyboardType: TextInputType.name,
                    readOnly: !isEditing,
                  ),
                  _ProfileField(
                    label: 'Email',
                    icon: Icons.email,
                    controller: authEmailController,
                    errorText: null,
                    hint: authEmail ?? 'No email available',
                    onChanged: (value) {},
                    keyboardType: TextInputType.emailAddress,
                    readOnly: true,
                  ),

                  // Password display (for security, we don't show it)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.lock,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Password',
                                style: textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              Text(
                                '••••••••', // Security: don't show actual password
                                style: textTheme.bodyMedium?.copyWith(
                                  fontFamily: 'monospace',
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  _ProfileField(
                    label: 'Phone Number',
                    icon: Icons.phone,
                    controller: phoneController,
                    errorText: profileState.fieldErrors?['phone'],
                    hint: 'Enter your phone number',
                    onChanged: profileController.updatePhone,
                    keyboardType: TextInputType.phone,
                    readOnly: !isEditing,
                  ),

                  if (isEditing) ...[
                    const SizedBox(height: 40),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: cancelEdit,
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Cancel'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: profileController.isFormValid
                                ? saveProfile
                                : null,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: profileState.isSaving
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text('Save'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
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
                          style: textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                          ),
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
  final bool readOnly;

  const _ProfileField({
    required this.label,
    required this.icon,
    required this.controller,
    this.errorText,
    required this.hint,
    required this.onChanged,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
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
        readOnly: widget.readOnly,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hint,
          errorText: widget.errorText,
          prefixIcon: Icon(widget.icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: widget.readOnly
              ? theme.colorScheme.surfaceContainerLowest
              : theme.colorScheme.surfaceContainerHighest,
        ),
        keyboardType: widget.keyboardType,
        onChanged: widget.onChanged,
      ),
    );
  }
}
