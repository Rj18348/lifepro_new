import 'package:lifepro_new/core/services/local_storage_service.dart';
import 'package:lifepro_new/domain/entities/daily_entry.dart';
import 'package:lifepro_new/domain/repositories/wellbeing_repository.dart';

class MockLocalStorageService implements LocalStorageService {
  @override
  Future<void> delete(String boxName, String key) async {}

  @override
  Future<dynamic> get(String boxName, String key) async => null;

  @override
  Future<List> getAll(String boxName) async => [];

  @override
  Future<void> init() async {}

  @override
  Future<void> save(String boxName, String key, value) async {}
}

class MockWellbeingRepository implements WellbeingRepository {
  @override
  Future<void> deleteEntry(String id) async {}

  @override
  Future<DailyEntry?> getEntry(DateTime date) async => null;

  @override
  Future<List<DailyEntry>> getHistory() async => [];

  @override
  Future<void> saveEntry(DailyEntry entry) async {}
}
