import 'dart:convert';
import 'package:cek_resi/config/constants.dart';
import 'package:cek_resi/models/tracking_result.dart';
import 'package:http/http.dart' as http;

class TrackingService {
  static Future<TrackingResult?> trackPackage(String resi, String courier) async {
    try {
      final response = await http.get(
        Uri.parse('${AppConstants.apiUrl}?api_key=${AppConstants.apiKey}&courier=$courier&awb=$resi'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return TrackingResult.fromBinderbyteJson(data);
      } else {
        throw Exception('Failed to load tracking data');
      }
    } catch (e) {
      return null;
    }
  }
}