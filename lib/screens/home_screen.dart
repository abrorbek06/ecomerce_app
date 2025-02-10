import 'package:ecomerce_app/news_api_service.dart';
import 'package:ecomerce_app/resours/colors.dart';
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
        // print(_weatherData);
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
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text('Weather App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _TextFeild("Search country"),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : _weatherData != null
                ? Card(
              child: ListTile(
                title: Text(
                  _weatherData!['name'] ?? 'No data',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Temperature: ${_weatherData!['main']['temp']} °C"),
                    Text("Description: ${_weatherData!['weather'][0]['description']}"),
                    Text("Wind Speed: ${_weatherData!['wind']['speed']} m/s"),
                    Text("Country: ${_weatherData!['sys']['country']}"),
                    Row(
                      children: [
                        const Text("Location:  "),
                        Text("Lon: ${_weatherData!['coord']['lon']}   "),
                        Text("Lat: ${_weatherData!['coord']['lat']}"),
                      ],
                    )
                  ],
                ),
              ),
            )
                : const Text('Enter a city name to see the weather'),
          ],
        ),
      ),
    );
  }
  _TextFeild(text) => Padding(
    padding: const EdgeInsets.only(bottom: 19),
    child: TextField(
      onTap: _searchWeather,
      controller: _cityController,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.only(left: 10),
        hintText: text,
        hintStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: AppColors.secondryColor
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 1.6,
            color: AppColors.textColor,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.textColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
              width: 1,
              color: AppColors.textColor
          ),
        ),
      ),
    ),
  );
}



class NewsApp extends StatefulWidget {
  @override
  _NewsAppState createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {
  final NewsApiService _newsApiService = NewsApiService();
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _articles = [];
  bool _isLoading = false;

  void _searchNews() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final articles = await _newsApiService.fetchNews(_searchController.text);
      setState(() {
        print(articles);
        _articles = articles;
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
        title: const Text('News Search'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Enter keyword',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _searchNews,
                ),
              ),
            ),
            const SizedBox(height: 10),
            _isLoading
                ? const CircularProgressIndicator()
                : Expanded(
              child: ListView.builder(
                itemCount: _articles.length,
                itemBuilder: (context, index) {
                  final article = _articles[index];
                  return Card(
                    child: ListTile(
                      leading: article['urlToImage'] != null
                          ? Image.network(article['urlToImage'], width: 50, height: 50, fit: BoxFit.cover)
                          : const Icon(Icons.image, size: 50),
                      title: Text(article['title'] ?? 'No Title'),
                      subtitle: Text(article['description'] ?? 'No Description'),
                      onTap: () => _openArticle(context, article['title'], article['urlToImage'], article['description'], article['content']),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openArticle(BuildContext context, String? url, String image, String description, String content) {
    if (url != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebViewScreen(url: url, image: image, description: description, content: content,),
        ),
      );
    }
  }
}

class WebViewScreen extends StatelessWidget {
  final String url;
  final String image;
  final String description;
  final String content;
  WebViewScreen({required this.url, required this.image, required this.description, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text('Article'),
      ),
      body: Column(
        children: [
          Image.network(image, fit: BoxFit.cover),
          Center(
            child: Text(url),
          ),
          Text(description),
          Text(content),
        ],
      ),
    );
  }
}