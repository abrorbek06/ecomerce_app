import 'package:ecomerce_app/news_api_service.dart';
import 'package:ecomerce_app/resours/assets.dart';
import 'package:ecomerce_app/resours/colors.dart';
import 'package:ecomerce_app/resours/styles.dart';
import 'package:ecomerce_app/screens/WebViewScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
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
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Temperature: ${_weatherData!['main']['temp']} °C"),
                              Text(
                                  "Description: ${_weatherData!['weather'][0]['description']}"),
                              Text(
                                  "Wind Speed: ${_weatherData!['wind']['speed']} m/s"),
                              Text(
                                  "Country: ${_weatherData!['sys']['country']}"),
                              Row(
                                children: [
                                  const Text("Location:  "),
                                  Text(
                                      "Lon: ${_weatherData!['coord']['lon']}   "),
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
                color: AppColors.secondryColor),
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
              borderSide:
                  const BorderSide(width: 1, color: AppColors.textColor),
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
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
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
        title: SvgPicture.asset(Assets.logoSVG),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
        child: Column(
          children: [
            _getSearch(),
            const SizedBox(height: 10),
            _isLoading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: _articles.length,
                      itemBuilder: (context, index) {
                        final article = _articles[index];
                        return GestureDetector(
                          onTap: () {
                            _openArticle(
                              context,
                              article['title'] ?? 'No Title',
                              article['urlToImage'] ?? 'No Title',
                              article['description'] ?? 'No Title',
                              article['author'] ?? 'No Title',
                              article['name'] ?? 'No Title',
                            );
                          },
                          child: SizedBox(
                            height: 330,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 183,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      image: DecorationImage(
                                        image: article['urlToImage'] != null
                                            ? NetworkImage(
                                                article['urlToImage'])
                                            : AssetImage(Assets.logoSVG),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const Text(""),
                                  const SizedBox(height: 8),
                                  Text(
                                    article['author'] ?? 'No Title',
                                    style: AppStyles.author,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    article['title'] ?? 'No Title',
                                    style: AppStyles.description,
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Text(
                                        article['source']['name'] ?? 'No Title',
                                        style: AppStyles.nameStyle,
                                      ),
                                      // Text(article['publishedAt'] ?? 'No Title', style: AppStyles.nameStyle,),
                                    ],
                                  )
                                ],
                              ),
                            ),
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

  _getSearch() => SizedBox(
        height: 50,
        child: TextField(
          controller: _searchController,
          textInputAction: TextInputAction.search,
          onTap: _searchNews,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white,
            contentPadding: const EdgeInsets.only(left: 10),
            hintText: "Search \"News\"",
            hintStyle: const TextStyle(
              color: AppColors.gray,
              fontWeight: FontWeight.w500,
            ),
            prefixIcon: const Icon(Icons.search),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.gray,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.mainColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.bgColor,
                width: 1,
              ),
            ),
          ),
        ),
      );
  void _openArticle(BuildContext context, String title, String image, String description, String author, String name) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Webviewscreen(
            title: title,
            image: image,
            description: description,
            author: author,
            name: name,
          ),
        ),
      );
  }
}
