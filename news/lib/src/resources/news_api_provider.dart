import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/item_model.dart';
import 'news_repository.dart';

final _baseURL = 'https://hacker-news.firebaseio.com/v0';
final listOfKids = [
  8952,
  9224,
  8917,
  8884,
  8887,
  8943,
  8869,
  8958,
  9005,
  9671,
  8940,
  9067,
  8908,
  9055,
  8865,
  8881,
  8872,
  8873,
  8955,
  10403,
  8903,
  8928,
  9125,
  8998,
  8901,
  8902,
  8907,
  8894,
  8878,
  8870,
  8980,
  8934,
  8876
];

class NewsApiProvider implements Source {
  Client client = Client();

  Future<List<int>> fetchTopIds() async {
    final response = await client.get('$_baseURL/topstories.json');
    final ids = json.decode(response.body);
    return ids.cast<int>();
  }

  Future<ItemModel> fetchItem(int id) async {
    var mockJson = {
      "by": "dhouston",
      "descendants": 71,
      "id": 8863,
      "kids": [],
      "score": 111,
      "time": 1175714200,
      // "title": "My YC app: Dropbox - Throw away your USB drive",
      "title": "My YC app.",
      "type": "story",
      "url": "http://www.getdropbox.com/u/2/screencast.html"
    };

    // DUE TO HACKER NEWS PROBLEM
    if(!listOfKids.contains(id)) {
      mockJson["kids"] = listOfKids;
    }

    try {
      // USING MOCK BECAUSE HACKER NEWS API IS OFF
      mockJson["id"] = id;

      //simulate loading when using mock
      await Future.delayed(Duration(seconds: 1));
      return ItemModel.fromJson(mockJson);

      // permission denied error
      // final response = await client.get('$_baseURL/$id.json');
      // print(response.body);
      // final parsedJson = json.decode(response.body);
      // return ItemModel.fromJson(parsedJson);
    } catch (err) {
      print(err.toString());
    }
  }
}
