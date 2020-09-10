import 'package:flutter/material.dart';
import 'screens/news_list.dart';
import 'screens/news_detail.dart';
import 'blocs/stories_provider.dart';
import 'blocs/comments_provider.dart';

class App extends StatelessWidget {
  Widget build(context) {
    // Now StoriesProvider and CommentsProvider are available for everything inside MaterialApp
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          title: 'News',
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    // with more routes you might need a switch/case statement
    if (settings.name == "/") {
      return MaterialPageRoute(builder: (context) {
        final storiesBloc = StoriesProvider.of(context);

        storiesBloc.fetchTopIds();

        return NewsList();
      });
    } else {
      return MaterialPageRoute(builder: (context) {
        // here's a great place to do initialization
        // or data fetching or formatting, etc
        final commentsbloc = CommentsProvider.of(context);
        final itemId = int.parse(settings.name.replaceFirst('/news/', ''));

        commentsbloc.fetchItemWithComments(itemId);

        return NewsDetail(itemId: itemId);
      });
    }
  }
}
