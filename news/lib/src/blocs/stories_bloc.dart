import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/news_repository.dart';

class StoriesBloc {
  final _repository = NewsRepository();
  final _topIds = PublishSubject<List<int>>();
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _itemsFetcher = PublishSubject<int>();

  Observable<List<int>> get topIds => _topIds.stream;
  Observable<Map<int, Future<ItemModel>>> get items => _itemsOutput.stream;

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

// Our items fetcher receive the fetch command
  Function(int) get fetchItem => _itemsFetcher.sink.add;

  StoriesBloc() {
    // to prevent multiple duplicated events, we pipe the result of itemsFetcher
    // to our itemsOutput stream, so itemsOutput will receive the latest result
    // from itemsFetcher and return to any item that want to consume our cached maps
    _itemsFetcher.stream.transform(_itemsTransformer()).pipe(_itemsOutput);
  }

  // should be executed only once, otherwise we'll have a individual cache
  // for each element (definitely not what we want)
  // This is needed because we have stateless widgets that consume our stream,
  // and since they're stateless they can't keep item data
  _itemsTransformer() {
    return ScanStreamTransformer(
      // Will be executed whenever a new item arrives
      (Map<int, Future<ItemModel>> cache, int id, _) {
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      // Default value: an empty map
      <int, Future<ItemModel>>{},
    );
  }

  clearCache() {
    return _repository.clearCache();
  }

  dispose() {
    _topIds.close();
    _itemsOutput.close();
    _itemsFetcher.close();
  }
}
