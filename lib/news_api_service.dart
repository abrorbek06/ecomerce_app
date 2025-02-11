import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class NewsApiService {
  static const String apiKey = 'fce4155e53784ef293db2473682ab023';
  static const String baseUrl = 'https://newsapi.org/v2/everything';

  Future<List<dynamic>> fetchNews(String keyword) async {
    try {
      final Uri url = Uri.parse('$baseUrl?q=$keyword&apiKey=$apiKey&language=en&sortBy=relevancy');
      final http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        if (jsonData['status'] == 'ok') {
          return jsonData['articles'];
        } else if (response.statusCode == 400){
          throw Exception('Internet not connaction');
        } else if (response.statusCode == 404) {
          throw Exception('404');
        } else {
          return [];
        }
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }
}


class WeatherService {
  static const String apiKey = '6418b539e0697f54de8a3df65ebe9444';
  static const String baseUrl = 'http://api.openweathermap.org/data/2.5/weather';
  static const String language = 'en';

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final Uri url = Uri.parse('$baseUrl?q=$city&appid=$apiKey&units=metric&lang=$language');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 400){
        throw Exception('Internet not connaction');
      } else if (response.statusCode == 404) {
        throw Exception('404');
      }else {
        throw Exception('City not found');
      }
    } catch (e) {
      throw Exception('Error fetching weather data: $e');
    }
  }
}
