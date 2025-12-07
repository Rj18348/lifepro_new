import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lifepro_new/presentation/home/home_screen.dart';
import 'package:lifepro_new/presentation/providers/providers.dart';
import 'package:lifepro_new/presentation/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final appInit = ref.watch(appInitProvider);

    return MaterialApp(
      title: 'LifeBalance AI',
      // Provide default themes (used by certain widgets), but we'll animate
      // the active ThemeData via the builder's AnimatedTheme so changes are smooth.
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: appInit.when(
        data: (_) => const HomeScreen(),
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (e, st) => Scaffold(body: Center(child: Text('Error: $e'))),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'), // English
        Locale('ar', 'SA'), // Arabic
        Locale('he', 'IL'), // Hebrew
        Locale('ur', 'PK'), // Urdu
        Locale('fa', 'IR'), // Persian
      ],
      builder: (context, child) {
        // Resolve the effective brightness when ThemeMode.system is selected
        final Brightness resolved = themeMode == ThemeMode.system
            ? MediaQuery.of(context).platformBrightness
            : (themeMode == ThemeMode.dark
                  ? Brightness.dark
                  : Brightness.light);

        final ThemeData animatedTheme = resolved == Brightness.dark
            ? AppTheme.darkTheme
            : AppTheme.lightTheme;

        return AnimatedTheme(
          data: animatedTheme,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: child!,
        );
      },
    );
  }
}
