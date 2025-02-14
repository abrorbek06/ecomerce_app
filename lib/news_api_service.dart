import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class NewsService {
  static const String apiKey = 'fce4155e53784ef293db2473682ab023';
  static const String everythingUrl = 'https://newsapi.org/v2/everything';
  static const String topHeadlinesUrl = 'https://newsapi.org/v2/top-headlines';

  Future<List<Map<String, dynamic>>> fetchNews({String keyword = ''}) async {
    final Uri url = keyword.isEmpty
        ? Uri.parse('$topHeadlinesUrl?country=us&apiKey=$apiKey')
        : Uri.parse('$everythingUrl?q=$keyword&apiKey=$apiKey&language=en&sortBy=publishedAt');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'ok' && data['totalResults'] > 0) {
          List<Map<String, dynamic>> newsList = [];
          for (var article in data['articles']) {
            String publishedAt = article['publishedAt'] ?? 'N/A';

            // Sanani YYYY-MM-DD formatida o'zgartirish
            String formattedDate = 'N/A';
            DateTime? parsedDate;
            if (publishedAt != 'N/A') {
              parsedDate = DateTime.parse(publishedAt);
              formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
            }

            newsList.add({
              'author': article['author'] ?? 'No title',
              'title': article['title'] ?? 'No title',
              'description': article['description'] ?? 'No description',
              'url': article['url'] ?? '#',
              'imageUrl': article['urlToImage'] ?? '',
              'name': article['name'] ?? '',
              'publishedAt': formattedDate, // Faqat sana
              'dateTime': parsedDate, // Saralash uchun
            });
          }

          // Sanaga qarab saralash (so‘nggi yangiliklar birinchi chiqishi uchun)
          newsList.sort((a, b) => (b['dateTime'] ?? DateTime(0)).compareTo(a['dateTime'] ?? DateTime(0)));

          return newsList;
        } else {
          throw Exception('No articles found');
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
      } else if (response.statusCode == 500){
        throw Exception('Error');
      }
      else {
        throw Exception('City not found');
      }
    } catch (e) {
      throw Exception('Error fetching weather data: $e');
    }
  }
}
