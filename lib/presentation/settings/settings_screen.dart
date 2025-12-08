import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';
import '../providers/providers.dart';
import 'package:lifepro_new/presentation/screens/login_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // App Settings Section
          _SettingsSection(
            title: "App Settings",
            children: [
              _SettingsTile(
                icon: Icons.palette_outlined,
                title: "Appearance",
                subtitle: "Customize the look and feel",
                trailing: DropdownButtonHideUnderline(
                  child: DropdownButton<ThemeMode>(
                    value: themeMode,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: colorScheme.primary,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    dropdownColor: colorScheme.surfaceContainer,
                    items: const [
                      DropdownMenuItem(
                        value: ThemeMode.system,
                        child: Text("System"),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.light,
                        child: Text("Light"),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.dark,
                        child: Text("Dark"),
                      ),
                    ],
                    onChanged: (ThemeMode? newMode) {
                      if (newMode != null) {
                        ref.read(themeProvider.notifier).setMode(newMode);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _SettingsTile(
                icon: Icons.notifications_active_outlined,
                title: "Daily Reminders",
                subtitle: "Get reminded to check in",
                trailing: Switch(
                  value: true, // Mock value
                  onChanged: (value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Notifications settings coming soon'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Data & Privacy Section
          _SettingsSection(
            title: "Data & Privacy",
            children: [
              _SettingsTile(
                icon: Icons.cloud_upload_outlined,
                title: "Backup Data",
                subtitle: "Sync to secure cloud storage",
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Backup flow coming soon')),
                  );
                },
              ),
              const SizedBox(height: 8),
              _SettingsTile(
                icon: Icons.lock_outline,
                title: "Security",
                subtitle: "App lock and biometrics",
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Security settings coming soon'),
                    ),
                  );
                },
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Support Section
          _SettingsSection(
            title: "Support & About",
            children: [
              _SettingsTile(
                icon: Icons.help_outline,
                title: "Help Center",
                onTap: () {},
              ),
              const SizedBox(height: 8),
              _SettingsTile(
                icon: Icons.info_outline,
                title: "About LifePro",
                subtitle: "Version 1.0.0",
                onTap: () {
                  showAboutDialog(
                    context: context,
                    applicationName: "LifePro",
                    applicationVersion: "1.0.0",
                    applicationLegalese: "© 2024 LifePro Inc.",
                    children: [
                      const SizedBox(height: 24),
                      const Text("Designed for your wellbeing."),
                    ],
                  );
                },
              ),
            ],
          ),

          // Account Section
          _SettingsSection(
            title: "Account",
            children: [
              _SettingsTile(
                icon: Icons.logout_outlined,
                title: "Logout",
                subtitle: "Sign out of your account",
                onTap: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text('Logout'),
                        ),
                      ],
                    ),
                  );

                  if (confirm == true) {
                    final authService = ref.read(authServiceProvider);
                    await authService.logout();
                    // Check if context is still valid before navigating
                    if (context.mounted) {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                        (route) => false,
                      );
                    }
                  }
                },
              ),
            ],
          ),

          const SizedBox(height: 48),
          Center(
            child: Text(
              "Made with ❤️",
              style: textTheme.labelMedium?.copyWith(
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 12),
          child: Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest.withValues(
              alpha: 0.3,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(children: children),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: theme.colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: theme.colorScheme.onSecondaryContainer,
                size: 22,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null)
              trailing!
            else if (onTap != null)
              Icon(
                Icons.chevron_right,
                size: 20,
                color: theme.colorScheme.onSurfaceVariant,
              ),
          ],
        ),
      ),
    );
  }
}
