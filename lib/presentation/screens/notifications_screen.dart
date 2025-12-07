import 'package:flutter/material.dart';
import 'package:lifepro_new/presentation/settings/settings_screen.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
      ),
      body: SafeArea(
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                Icons.notifications_none_rounded,
                size: 32,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 12),
              Text(
                "Your Notifications",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "Stay updated with your wellbeing journey",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),

          // Sample Notifications
          _buildNotificationCard(
            context,
            theme,
            "Daily Meditation Reminder",
            "It's time for your daily mindfulness practice!",
            "2 hours ago",
            Icons.self_improvement,
            Colors.purple,
          ),
          const SizedBox(height: 12),
          _buildNotificationCard(
            context,
            theme,
            "Streak Achievement!",
            "You've maintained a 7-day wellness streak. Keep it up!",
            "1 day ago",
            Icons.local_fire_department,
            Colors.orange,
          ),
          const SizedBox(height: 12),
          _buildNotificationCard(
            context,
            theme,
            "Mood Check-in",
            "How are you feeling today? Let's track your mood.",
            "3 days ago",
            Icons.sentiment_satisfied,
            Colors.blue,
          ),
          const SizedBox(height: 12),
          _buildNotificationCard(
            context,
            theme,
            "Weekly Progress Report",
            "Your weekly wellbeing summary is ready to view.",
            "1 week ago",
            Icons.bar_chart,
            Colors.green,
          ),

          const SizedBox(height: 24),

          // Settings
          Text(
            "Notification Settings",
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            elevation: 0,
            color: theme.colorScheme.surfaceContainerLow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Icon(
                Icons.settings,
                color: theme.colorScheme.primary,
              ),
              title: const Text("Customize Notifications"),
              subtitle: const Text("Manage your notification preferences"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(
    BuildContext context,
    ThemeData theme,
    String title,
    String message,
    String time,
    IconData icon,
    Color iconColor,
  ) {
    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerHigh,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    time,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant.withValues(
                        alpha: 0.7,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
