import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

// Abstract classes in flutter works as interfaces
abstract class Cache {
  Future<int> addItem(ItemModel item);
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

class NewsRepository {
  List<Source> sources = <Source>[
    newsDbProvider,
    NewsApiProvider(),
  ];

  List<Cache> caches = <Cache>[
    newsDbProvider,
  ];

  Future<List<int>> fetchTopIds() {
    // since our newsDbProvider has a fake 'fetchTopIds'
    // we'll call the apiProvider directly
    // but in a real project situation we would do the 
    // for source in sources solution
    return sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    Source source;

    // will look in each source (in the sources order) and 
    // call fetchItem until it finds a valid item
    for(source in sources) {
      // null or the item
      item = await source.fetchItem(id);

      if(item != null) {
        break;
      }
    }

    for (var cache in caches) {
      cache.addItem(item);
    }

    return item;
  }
}