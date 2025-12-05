import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifepro_new/presentation/providers/providers.dart';
import 'package:lifepro_new/presentation/screens/test_wellbeing_screen.dart';
import 'package:lifepro_new/presentation/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // We don't await init here directly to show a splash/loading screen if needed,
  // but for MVP we can wrap in a ProviderScope and use an AsyncValue in the main widget 
  // or just simple await for now.
  
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initStatus = ref.watch(appInitProvider);
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      title: 'LifeBalance AI',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
      home: initStatus.when(
        data: (_) => const TestWellbeingScreen(),
        error: (err, stack) => Scaffold(
          body: Center(child: Text('Error: $err')),
        ),
        loading: () => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
