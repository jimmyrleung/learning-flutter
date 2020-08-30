import 'package:flutter/material.dart';
import 'screens/news_list.dart';
import 'blocs/stories_provider.dart';

class App extends StatelessWidget {
  Widget build(context) {

    // Now our StoriesProvider is available for everything inside MaterialApp
    return StoriesProvider(
      child: MaterialApp(
        title: 'News',
        home: NewsList(),
      ),
    );
  }
}
