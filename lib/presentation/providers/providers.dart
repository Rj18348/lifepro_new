import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifepro_new/core/services/local_storage_service.dart';
import 'package:lifepro_new/core/services/hive_storage_service.dart';
import 'package:lifepro_new/domain/repositories/wellbeing_repository.dart';
import 'package:lifepro_new/data/repositories/wellbeing_repository_impl.dart';

// Service Providers
final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return HiveLocalStorageService();
});

// Repository Providers
final wellbeingRepositoryProvider = Provider<WellbeingRepository>((ref) {
  final storage = ref.watch(localStorageServiceProvider);
  return WellbeingRepositoryImpl(storage);
});

// Initialization Provider (to be awaited in main)
final appInitProvider = FutureProvider<void>((ref) async {
  await ref.read(localStorageServiceProvider).init();
});
