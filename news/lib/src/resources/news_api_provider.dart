import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/item_model.dart';

final _baseURL = 'https://hacker-news.firebaseio.com/v0';

class NewApiProvider {
  Client client = Client();

  fetchTopIds() async {
    final response = await client.get('$_baseURL/topstories.json');
    final ids = json.decode(response.body);
    return ids;
  }

  fetchItem(int id) async {
    final response = await client.get('$_baseURL/$id.json');
    final parsedJson = json.decode(response.body);

    return ItemModel.fromJson(parsedJson);
  }
}