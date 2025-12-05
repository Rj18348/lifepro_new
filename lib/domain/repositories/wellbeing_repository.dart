import 'package:lifepro_new/domain/entities/daily_entry.dart';

abstract class WellbeingRepository {
  Future<void> saveEntry(DailyEntry entry);
  Future<DailyEntry?> getEntry(DateTime date);
  Future<List<DailyEntry>> getHistory();
  Future<void> deleteEntry(String id);
}
