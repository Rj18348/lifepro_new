import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              "Reports",
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Your mental health insights",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),

            // Weekly Summary Card
            _buildWeeklySummaryCard(theme),
            const SizedBox(height: 16),

            // Mood Trends
            _buildMoodTrendsCard(theme),
            const SizedBox(height: 16),

            // Activities Completed
            _buildActivitiesCard(theme),
            const SizedBox(height: 16),

            // Report Categories
            Text(
              "Report Categories",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            _buildReportCategories(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklySummaryCard(ThemeData theme) {
    return Card(
      elevation: 0,
      color: theme.colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Weekly Summary",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                Icon(
                  Icons.calendar_today,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Stats Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  theme,
                  "7",
                  "Days Active",
                  theme.colorScheme.onPrimaryContainer,
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: theme.colorScheme.onPrimaryContainer.withValues(
                    alpha: 0.3,
                  ),
                ),
                _buildStatItem(
                  theme,
                  "12",
                  "Activities",
                  theme.colorScheme.onPrimaryContainer,
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: theme.colorScheme.onPrimaryContainer.withValues(
                    alpha: 0.3,
                  ),
                ),
                _buildStatItem(
                  theme,
                  "85%",
                  "Progress",
                  theme.colorScheme.onPrimaryContainer,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Progress Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: 0.85,
                minHeight: 8,
                backgroundColor: theme.colorScheme.onPrimaryContainer
                    .withValues(alpha: 0.2),
                valueColor: AlwaysStoppedAnimation<Color>(
                  theme.colorScheme.onPrimaryContainer,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    ThemeData theme,
    String value,
    String label,
    Color color,
  ) {
    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: color.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildMoodTrendsCard(ThemeData theme) {
    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Mood Trends",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(Icons.trending_up, color: theme.colorScheme.primary),
              ],
            ),
            const SizedBox(height: 20),

            // Mood Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMoodIndicator(theme, "😊", "Happy", 45),
                _buildMoodIndicator(theme, "😌", "Calm", 30),
                _buildMoodIndicator(theme, "😔", "Low", 15),
                _buildMoodIndicator(theme, "😰", "Stress", 10),
              ],
            ),
            const SizedBox(height: 20),

            // Insight Text
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.secondaryContainer.withValues(
                  alpha: 0.3,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    color: theme.colorScheme.secondary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Your mood has been mostly positive this week!",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
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

  Widget _buildMoodIndicator(
    ThemeData theme,
    String emoji,
    String label,
    int percentage,
  ) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                value: percentage / 100,
                strokeWidth: 5,
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
                valueColor: AlwaysStoppedAnimation<Color>(_getMoodColor(label)),
              ),
            ),
            Text(emoji, style: const TextStyle(fontSize: 24)),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          "$percentage%",
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Color _getMoodColor(String mood) {
    switch (mood) {
      case "Happy":
        return Colors.green;
      case "Calm":
        return Colors.blue;
      case "Low":
        return Colors.orange;
      case "Stress":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildActivitiesCard(ThemeData theme) {
    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Activities Completed",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),

            _buildActivityItem(
              theme,
              Icons.self_improvement,
              "Meditation",
              5,
              Colors.purple,
            ),
            const SizedBox(height: 12),
            _buildActivityItem(
              theme,
              Icons.article_outlined,
              "Journal",
              7,
              Colors.orange,
            ),
            const SizedBox(height: 12),
            _buildActivityItem(
              theme,
              Icons.psychology_outlined,
              "Mind Detox",
              3,
              Colors.teal,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(
    ThemeData theme,
    IconData icon,
    String name,
    int count,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            name,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            "$count times",
            style: theme.textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReportCategories(ThemeData theme) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: [
        _buildCategoryCard(
          theme,
          Icons.psychology,
          "Mental Health",
          Colors.purple.shade300,
        ),
        _buildCategoryCard(
          theme,
          Icons.fitness_center,
          "Physical",
          Colors.blue.shade300,
        ),
        _buildCategoryCard(
          theme,
          Icons.nightlight,
          "Sleep",
          Colors.indigo.shade300,
        ),
        _buildCategoryCard(
          theme,
          Icons.restaurant,
          "Nutrition",
          Colors.green.shade300,
        ),
      ],
    );
  }

  Widget _buildCategoryCard(
    ThemeData theme,
    IconData icon,
    String label,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
