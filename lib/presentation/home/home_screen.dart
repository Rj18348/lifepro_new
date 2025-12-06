import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifepro_new/presentation/screens/settings_screen.dart';
import 'home_controller.dart';
import 'home_state.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeControllerProvider);

    return Scaffold(
      body:
          state.isLoading &&
              state.points ==
                  0 // Show loading on initial load only if no data
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () =>
                  ref.read(homeControllerProvider.notifier).refresh(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHeader(context),
                    const SizedBox(height: 20),
                    _buildCheckInSection(context, state),
                    const SizedBox(height: 24),
                    _buildPlanSection(context, state),
                    const SizedBox(height: 24),
                    _buildQuickActions(context, state),
                    const SizedBox(height: 32),
                    _buildEmergencyButton(context),
                    const SizedBox(height: 32), // Bottom padding
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Good Morning,",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Frede \ud83d\udc4b",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              _NotificationDotButton(
                icon: Icons.notifications_none_rounded,
                onTap: () {
                  // TODO: Open notifications
                },
              ),
              const SizedBox(width: 8),
              _NotificationDotButton(
                icon: Icons.settings_outlined,
                showDot: false,
                onTap: () {
                  final route = MaterialPageRoute(
                    builder: (_) => const SettingsScreen(),
                  );
                  Navigator.of(context).push(route);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCheckInSection(BuildContext context, HomeState state) {
    if (state.hasCheckedIn) {
      return Card(
        elevation: 2,
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "You're checked in!",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Mood: ${state.moodToday ?? 'Unknown'}",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              "How are you feeling today?",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              "Track your mood and stress to unlock your daily plan.",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: () {
                // TODO: Navigate to check-in flow
                // For demo, we might simulate check-in via controller
                ref
                    .read(homeControllerProvider.notifier)
                    .completeCheckIn("Good", 3);
              },
              icon: const Icon(Icons.check_circle_outline),
              label: const Text("Start Daily Check-In"),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanSection(BuildContext context, HomeState state) {
    if (!state.hasCheckedIn) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(
            context,
          ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.lock_outline,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                "Your daily plan will appear here after you check in.",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      );
    }

    // If checked in, show plan (mock or real)
    final plan = state.todayPlan;
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today's Plan",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Icon(
                  Icons.auto_awesome,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (plan == null)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text("Generating your personalized plan..."),
              )
            else
              Text(
                "Plan content would go here...",
              ), // Placeholder for plan details
            // Fallback content visualization
            ListTile(
              leading: const CircleAvatar(child: Text("1")),
              title: const Text("Morning Mindfulness"),
              subtitle: const Text("5 min breathing exercise"),
              trailing: Checkbox(value: false, onChanged: (v) {}),
            ),
            ListTile(
              leading: const CircleAvatar(child: Text("2")),
              title: const Text("Hydration"),
              subtitle: const Text("Drink a glass of water"),
              trailing: Checkbox(value: false, onChanged: (v) {}),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context, HomeState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Quick Actions", style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _QuickActionCard(
                icon: Icons.self_improvement, // Micro-Intervention
                label: "Micro Steps",
                color: Colors.purple.shade100,
                onTap: () {
                  // TODO: Open Library
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _QuickActionCard(
                icon: Icons.book_outlined, // Journal
                label: "Journal",
                color: Colors.orange.shade100,
                onTap: () {
                  // TODO: Open Journal
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Streak and Points Row
        Row(
          children: [
            Expanded(
              child: Card(
                color: Theme.of(context).colorScheme.tertiaryContainer,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 8,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${state.streak}",
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(
                                context,
                              ).colorScheme.onTertiaryContainer,
                            ),
                      ),
                      Text(
                        "Day Streak",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onTertiaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Card(
                color: Theme.of(context).colorScheme.secondaryContainer,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 8,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${state.points}",
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSecondaryContainer,
                            ),
                      ),
                      Text(
                        "Points",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSecondaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text("Daily Trackers", style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildTrackerItem(
              context,
              Icons.water_drop_outlined,
              "Water",
              "${state.waterIntake}/8",
              () {
                ref
                    .read(homeControllerProvider.notifier)
                    .updateWater(state.waterIntake + 1);
              },
            ),
            const SizedBox(width: 12),
            _buildTrackerItem(
              context,
              Icons.directions_run_outlined,
              "Steps",
              "${state.steps}",
              () {
                ref
                    .read(homeControllerProvider.notifier)
                    .updateSteps(state.steps + 500);
              },
            ),
            const SizedBox(width: 12),
            _buildTrackerItem(
              context,
              Icons.bed_outlined,
              "Sleep",
              "${state.sleepHours}h",
              () {
                ref
                    .read(homeControllerProvider.notifier)
                    .updateSleep(state.sleepHours + 1);
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTrackerItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
    VoidCallback onTap,
  ) {
    final theme = Theme.of(context);
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest.withValues(
              alpha: 0.5,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(icon, color: theme.colorScheme.primary),
              const SizedBox(height: 4),
              Text(
                value,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmergencyButton(BuildContext context) {
    return Center(
      child: TextButton.icon(
        onPressed: () {
          // TODO: Open Emergency Modal
          showModalBottomSheet(
            context: context,
            builder: (context) => Container(
              padding: const EdgeInsets.all(24),
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Need Help?",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "You are not alone. Reach out to someone you trust.",
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Close"),
                  ),
                ],
              ),
            ),
          );
        },
        icon: Icon(
          Icons.support_agent,
          color: Theme.of(context).colorScheme.error,
        ),
        label: Text(
          "Need Help?",
          style: TextStyle(
            color: Theme.of(context).colorScheme.error,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          side: BorderSide(
            color: Theme.of(context).colorScheme.error.withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Using Material 3 Surface colors or tinted surfaces
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      color: theme.colorScheme.surfaceContainerHighest, // Defaults for M3
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: theme.colorScheme.primary),
              const SizedBox(height: 8),
              Text(
                label,
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationDotButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool showDot;

  const _NotificationDotButton({
    required this.icon,
    required this.onTap,
    this.showDot = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Material(
          color: theme.colorScheme.surface,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(icon, color: theme.colorScheme.onSurfaceVariant),
            ),
          ),
        ),
        if (showDot)
          Positioned(
            top: -1,
            right: -1,
            child: Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: Colors.pinkAccent,
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }
}
