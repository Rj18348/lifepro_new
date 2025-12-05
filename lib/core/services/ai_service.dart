
import 'package:lifepro_new/domain/entities/daily_entry.dart';

abstract class AIService {
  /// Returns a daily guidance/summary based on the user's entry.
  /// Throws an exception if AI is not enabled or network fails.
  Future<String> generateGuidance(DailyEntry entry);
  
  /// Helper to check if AI is currently available/enabled.
  bool get isEnabled;
}
