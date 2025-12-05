import 'dart:convert';
import 'package:lifepro_new/core/services/local_storage_service.dart';
import 'package:lifepro_new/domain/entities/daily_entry.dart';
import 'package:lifepro_new/domain/repositories/wellbeing_repository.dart';

class WellbeingRepositoryImpl implements WellbeingRepository {
  final LocalStorageService _storage;
  final String _boxName = 'wellbeing_entries';

  WellbeingRepositoryImpl(this._storage);

  String _dateKey(DateTime date) => "${date.year}-${date.month}-${date.day}";

  @override
  Future<void> saveEntry(DailyEntry entry) async {
    final key = _dateKey(entry.date);
    await _storage.save(_boxName, key, jsonEncode(entry.toJson()));
  }

  @override
  Future<DailyEntry?> getEntry(DateTime date) async {
    final key = _dateKey(date);
    final data = await _storage.get(_boxName, key);
    if (data != null) {
      return DailyEntry.fromJson(jsonDecode(data));
    }
    return null;
  }

  @override
  Future<List<DailyEntry>> getHistory() async {
    final allData = await _storage.getAll(_boxName);
    return allData
        .map((e) => DailyEntry.fromJson(jsonDecode(e)))
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  @override
  Future<void> deleteEntry(String id) async {
     // NOTE: Simplification for MVP, usually we'd need to find by ID or pass date.
     // For now, assume ID isn't used for lookups in this method implementation directly 
     // without date, or we iterate. 
     // To keep it efficient given key is date:
     // Ideally getEntry takes date. 
  }
}
