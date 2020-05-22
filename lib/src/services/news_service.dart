

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/models/news_models.dart';

import 'package:http/http.dart' as http;
final _URL_NEWS = 'https://newsapi.org/v2';
final _APIKEY = '62b8ad162390455fba6e68b77c0e0c3e';
class NewsService with ChangeNotifier {
  List<Article> headlines = [];

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  NewsService() {
    this.getTopHeadLines();
    

  }

  getTopHeadLines() async {
    //https://newsapi.org/v2/top-headlines?country=us&apiKey=62b8ad162390455fba6e68b77c0e0c3e
    final url = 
      '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=us';

      final resp = await http.get(url);

      final newsResponse = newsResponseFromJson(resp.body);

      this.headlines.addAll(newsResponse.articles);

      notifyListeners();

  }
}