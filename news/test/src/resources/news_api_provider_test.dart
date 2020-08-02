// Since this file is inside the 'test' directory, which is a
// directory that is not inside the 'lib' directory, we need to
// import files from the 'lib' as third party dependencies
import 'package:news/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('FetchTopIds returns a list of ids', () async {
    final newsApi = NewsApiProvider();

    // It's a good practice to let your client be reassigned, so you can
    // modify the http client to the mock client and all other functions
    // won't need to be changed with ifs considering environment variables,
    // etc.
    newsApi.client = MockClient((request) async {
      // you can use the request object to get some information
      // like the url that is being called in order to return
      // the appropriate response. This is useful when you want to
      // create a more generic MockClient that works for many tests
      // (not the case here)

      // In our case we are going to always return the same response
      // for all requests
      return Response(json.encode([1, 2, 3, 4]), 200);
    });

    final ids = await newsApi.fetchTopIds();

    expect(ids, [1, 2, 3, 4]);
  });

  test('FetchItem returns a item model', () async {
    final newsApi = NewsApiProvider();

    newsApi.client = MockClient((request) async {
      final mockItem = {
        "by": "dhouston",
        "descendants": 71,
        "id": 8863,
        "kids": [
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
        ],
        "score": 111,
        "time": 1175714200,
        "title": "My YC app: Dropbox - Throw away your USB drive",
        "type": "story",
        "url": "http://www.getdropbox.com/u/2/screencast.html"
      };

      return Response(json.encode(mockItem), 200);
    });

    final item = await newsApi.fetchItem(8863);

    expect(item.id, 8863);
  });
}
