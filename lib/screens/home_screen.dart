import 'package:ecomerce_app/news_api_service.dart';
import 'package:flutter/material.dart';

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final WeatherService _weatherService = WeatherService();
  final TextEditingController _cityController = TextEditingController();
  Map<String, dynamic>? _weatherData;
  bool _isLoading = false;

  void _searchWeather() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final data = await _weatherService.fetchWeather(_cityController.text);
      setState(() {
        _weatherData = data;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                hintText: 'Enter city name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchWeather,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : _weatherData != null
                ? Card(
              child: ListTile(
                title: Text(
                  _weatherData!['name'] ?? 'No data',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Temperature: ${_weatherData!['main']['temp']} °C"),
                    Text("Description: ${_weatherData!['weather'][0]['description']}"),
                    Text("Wind Speed: ${_weatherData!['wind']['speed']} m/s"),
                  ],
                ),
              ),
            )
                : Text('Enter a city name to see the weather'),
          ],
        ),
      ),
    );
  }
}