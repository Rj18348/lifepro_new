import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifepro_new/presentation/theme/app_theme.dart';

class TestWellbeingScreen extends ConsumerStatefulWidget {
  const TestWellbeingScreen({super.key});

  @override
  ConsumerState<TestWellbeingScreen> createState() =>
      _TestWellbeingScreenState();
}

class _TestWellbeingScreenState extends ConsumerState<TestWellbeingScreen> {
  double _energy = 5.0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Check-in", style: GoogleFonts.outfit()),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              ref.read(themeProvider.notifier).toggleTheme();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Greeting & Lottie Placeholder
              Center(
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primaryContainer.withValues(alpha: 0.3),
                    shape: BoxShape.circle,
                  ),
                  child:
                      Icon(
                            Icons.self_improvement,
                            size: 80,
                            color: Theme.of(context).colorScheme.primary,
                          )
                          .animate(onPlay: (c) => c.repeat(reverse: true))
                          .scale(
                            duration: 2.seconds,
                            begin: const Offset(0.9, 0.9),
                            end: const Offset(1.1, 1.1),
                          )
                          .shimmer(delay: 1.seconds, duration: 2.seconds),
                ),
              ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.2, end: 0),

              const SizedBox(height: 32),

              Text(
                "Good Afternoon,",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 200.ms),

              Text(
                "How is your energy right now?",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 400.ms),

              const SizedBox(height: 48),

              // 2. Interactive Slider
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.battery_0_bar),
                        Text(
                          "${_energy.round()}",
                          style: GoogleFonts.outfit(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: _getEnergyColor(_energy),
                          ),
                        ),
                        const Icon(Icons.battery_full),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: _getEnergyColor(_energy),
                        thumbColor: _getEnergyColor(_energy),
                        trackHeight: 10,
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 14.0,
                        ),
                      ),
                      child: Slider(
                        value: _energy,
                        min: 1,
                        max: 10,
                        onChanged: (val) => setState(() => _energy = val),
                      ),
                    ),
                  ],
                ),
              ).animate().scale(delay: 600.ms, curve: Curves.easeOutBack),

              const SizedBox(height: 32),

              // 3. Action Button
              FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.check),
                label: const Text("Log Entry"),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ).animate().fadeIn(delay: 800.ms).moveY(begin: 20, end: 0),
            ],
          ),
        ),
      ),
    );
  }

  Color _getEnergyColor(double value) {
    if (value < 4) return Colors.orangeAccent;
    if (value < 7) return Colors.teal;
    return Colors.green;
  }
}
