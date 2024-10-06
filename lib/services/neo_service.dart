import 'dart:convert';
import 'package:http/http.dart' as http;

class NeoService {
  static const String apiKey = 'aUhRrxzMSd8YlKOqh2kZnmiGph9nBmvAL8XIyEeP';
  static const String apiUrl =
      'https://api.nasa.gov/neo/rest/v1/feed/today?api_key=';

  Future<List<dynamic>> fetchNearEarthObjects() async {
    final response = await http.get(Uri.parse('$apiUrl$apiKey'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Access the near_earth_objects and get the first date
      final neos = data['near_earth_objects'] as Map<String, dynamic>;

      // Extracting the NEOs for the first available date
      if (neos.isNotEmpty) {
        // Get the first date key
        String firstDateKey = neos.keys.first;

        // Return the list of NEOs for that date
        return neos[firstDateKey] as List<dynamic>;
      }
    } else {
      throw Exception('Failed to load NEOs');
    }
    return []; // Return an empty list if no NEOs are found
  }
}
