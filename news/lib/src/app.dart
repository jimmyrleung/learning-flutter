import 'package:flutter/material.dart';
import 'screens/news_list.dart';
import 'screens/news_detail.dart';
import 'blocs/stories_provider.dart';

class App extends StatelessWidget {
  Widget build(context) {
    // Now our StoriesProvider is available for everything inside MaterialApp
    return StoriesProvider(
      child: MaterialApp(
        title: 'News',
        //home: NewsList(),
        onGenerateRoute: routes,
      ),
    );
  }

  Route routes(RouteSettings settings) {
    // with more routes you might need a switch/case statement
    if (settings.name == "/") {
      return MaterialPageRoute(builder: (context) {
        return NewsList();
      });
    } else {
      return MaterialPageRoute(builder: (context) {
        // here's a great place to do initialization
        // or data fetching or formatting, etc
        final itemId = int.parse(settings.name.replaceFirst('/news/', ''));
        return NewsDetail(itemId: itemId);
      });
    }
  }
}
