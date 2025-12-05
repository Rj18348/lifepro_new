
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifepro_new/core/services/ai_service.dart';
import 'package:lifepro_new/core/services/mock_ai_service.dart';

// State provider for AI enabled/disabled
final aiEnabledProvider = StateProvider<bool>((ref) => false); // Defaults to OFF

final aiServiceProvider = Provider<AIService>((ref) {
  // Logic to switch between Mock and Real based on configuration or compilation flags
  // For MVP/Dev, we use Mock.
  final mockService = MockAIService();
  
  // Reactively update service state if needed, but usually service instance is static, 
  // and method calls check the state. 
  // Here we sync the provider state to the service for the mock.
  final enabled = ref.watch(aiEnabledProvider);
  mockService.setEnabled(enabled);
  
  return mockService;
});
