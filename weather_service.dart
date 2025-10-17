import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  final String apiKey = '0e86d785a93bc6e3b4fa6e30ce0255ee';
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Map<String, dynamic>> getWeather(String city) async {
    final url = Uri.parse('$baseUrl?q=$city&units=metric&appid=$apiKey');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Hiba történt: ${response.statusCode}');
    }
  }
}
/Users/janoskulcsar/weather_app/lib/main.dart