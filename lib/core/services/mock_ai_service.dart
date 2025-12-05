
import 'package:lifepro_new/core/services/ai_service.dart';
import 'package:lifepro_new/domain/entities/daily_entry.dart';

class MockAIService implements AIService {
  bool _enabled = false;

  void setEnabled(bool value) {
    _enabled = value;
  }

  @override
  bool get isEnabled => _enabled;

  @override
  Future<String> generateGuidance(DailyEntry entry) async {
    if (!_enabled) {
      throw Exception('AI is disabled');
    }
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    
    return "This is a mock AI response for your mood score of ${entry.moodScore}. "
           "Keep focusing on what matters!";
  }
}
