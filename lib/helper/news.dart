import 'dart:convert';

import '../models/article_models.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=9cae2500ffd5409f9e23a8a577d632e2";

    var response = await http.get(Uri.parse(url));
    var jsondata = jsonDecode(response.body);
    if (jsondata['status'] == "ok") {
      jsondata["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urltoImage: element['urlToImage'],
            content: element['content'],
          );
          news.add(articleModel);
        }
      });
    }
  }
}
