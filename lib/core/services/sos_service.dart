import 'package:geolocator/geolocator.dart';
import 'package:lifepro_new/domain/entities/user_profile.dart';
import 'package:url_launcher/url_launcher.dart';

class SOSService {
  Future<String> _getCurrentLocationMessage() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return 'Location services disabled';
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return 'Location permission denied';
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return 'Location permission permanently denied';
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
      );

      return 'My current location: https://maps.google.com/?q=${position.latitude},${position.longitude}';
    } catch (e) {
      return 'Unable to get location: $e';
    }
  }

  Future<void> sendSOSAlert(UserProfile profile) async {
    if (profile.emergencyContacts.isEmpty) {
      throw Exception('No emergency contacts configured');
    }

    String locationMessage = '';
    if (profile.autoShareLocation) {
      locationMessage = '\n${await _getCurrentLocationMessage()}';
    }

    String message = 'SOS! Emergency alert from ${profile.fullName}. Please help!$locationMessage';

    for (final contact in profile.emergencyContacts) {
      try {
        // Send SMS
        final smsUri = Uri.parse('sms:${contact.phone}?body=${Uri.encodeComponent(message)}');
        await launchUrl(smsUri);
      } catch (e) {
        // If SMS fails, try call
        final callUri = Uri.parse('tel:${contact.phone}');
        await launchUrl(callUri);
      }
    }
  }

  Future<List<EmergencyServiceInfo>> getNearestEmergencyServices(double? latitude, double? longitude) async {
    // For simplicity, return static list. In real app, would use places API or database
    // Detect country from location or profile
    return [
      EmergencyServiceInfo(
        name: 'Emergency Services',
        phone: '911', // US
        type: 'Police/Fire/Medical',
      ),
      EmergencyServiceInfo(
        name: 'Nearest Hospital',
        phone: 'Emergency',
        type: 'Hospital',
      ),
      EmergencyServiceInfo(
        name: 'Ambulance',
        phone: '102', // India example
        type: 'Medical',
      ),
    ];
  }
}

class EmergencyServiceInfo {
  final String name;
  final String phone;
  final String type;

  EmergencyServiceInfo({required this.name, required this.phone, required this.type});
}
