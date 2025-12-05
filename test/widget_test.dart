import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifepro_new/main.dart';
import 'package:lifepro_new/presentation/providers/providers.dart';
import 'mocks.dart';

void main() {
  testWidgets('App starts and shows TestWellbeingScreen', (
    WidgetTester tester,
  ) async {
    // Setup Mocks
    final mockStorage = MockLocalStorageService();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [localStorageServiceProvider.overrideWithValue(mockStorage)],
        child: const MyApp(),
      ),
    );

    // Initial state might be loading
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Pump to settle futures
    await tester.pumpAndSettle();

    // Should show TestWellbeingScreen with new UI
    expect(find.text('Daily Check-in'), findsOneWidget);
    expect(find.text('How is your energy right now?'), findsOneWidget);
    expect(find.byType(Slider), findsOneWidget);
  });
}
