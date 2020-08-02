// Since this file is inside the 'test' directory, which is a 
// directory that is not inside the 'lib' directory, we need to
// import files from the 'lib' as third party dependencies
import 'package:news/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main () {
  test('FetchTopIds returns a list of ids', () async {
    final newsApi = NewsApiProvider();

    // It's a good practice to let your client be reassigned, so you can
    // modify the http client to the mock client and all other functions
    // won't need to be changed with ifs considering environment variables,
    // etc.
    newsApi.client = MockClient((request) async {
      // you can use the request object to get some information
      // like the url that is being called in order to return
      // the appropriate response

      // In our case we are going to always return the same response
      // for all requests
      return Response(json.encode([1, 2, 3, 4]), 200);
    });

    final ids = await newsApi.fetchTopIds();

    expect(ids, [1, 2, 3, 4]);
  });
}