import 'package:ecomerce_app/news_api_service.dart';
import 'package:ecomerce_app/resours/assets.dart';
import 'package:ecomerce_app/resours/colors.dart';
import 'package:ecomerce_app/resours/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'WebViewScreen.dart';

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

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final NewsService _newsService = NewsService();
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _news = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchLatestNews(); // Ilova ochilganda eng so‘nggi yangiliklarni yuklaydi
  }

  void _fetchLatestNews() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final data = await _newsService.fetchNews();
      setState(() {
        _news = data;
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

  void _searchNews() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final data =
          await _newsService.fetchNews(keyword: _searchController.text);
      setState(() {
        _news = data;
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

  void _clearSearch() {
    _searchController.clear();
    _fetchLatestNews(); // Qidiruv bo‘sh kiritilsa, yana eng so‘nggi yangiliklar chiqadi
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: SvgPicture.asset(Assets.logoSVG, width: 100),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            _getSearch(),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: _news.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => Webviewscreen(
                                  title: _news[index]['title'],
                                  image: _news[index]['imageUrl'],
                                  description: _news[index]['description'],
                                  author: _news[index]['author'],
                                  name: _news[index]['name'],
                                  ),
                            ),
                          ),
                          child: Card(
                              color: AppColors.white,
                              elevation: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 200,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: _news[index]['imageUrl'] !=
                                                    ''
                                                ? NetworkImage(
                                                    _news[index]['imageUrl'])
                                                : const AssetImage(
                                                    Assets.airplane),
                                            fit: BoxFit.cover)),
                                  ),
                                  Text(_news[index]['author'],
                                      style: AppStyles.author),
                                  const SizedBox(height: 12),
                                  Text(_news[index]['title'],
                                      style: AppStyles.description),
                                  const SizedBox(height: 5),
                                  Text(_news[index]['description'],
                                      style: const TextStyle(
                                          color: AppColors.secondryColor)),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Published on: ${_news[index]['publishedAt']}',
                                    style: AppStyles.description
                                        .copyWith(color: AppColors.textColor),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              )),
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

  void _openArticle(BuildContext context, String title, String author,
      String description, String image, String name) {
    if (title != null) {}
  }
}
