import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/news_repository.dart';

class StoriesBloc {
  final _repository = NewsRepository();
  final _topIds = PublishSubject<List<int>>();
  final _items = BehaviorSubject<int>(); 

  // This is the final result of a transformed stream
  // It has the cached map
  Observable<Map<int, Future<ItemModel>>> items;

  Observable<List<int>> get topIds => _topIds.stream;

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  Function(int) get fetchItem => _items.sink.add;

  StoriesBloc() {
    // Here's our cache is created
    // This returns a new stream reference that is transformed
    // This stream is the one that we want to expose
    items = _items.stream.transform(_itemsTransformer());
  }

  // should be executed only once, otherwise we'll have a individual cache
  // for each element (definitely not what we want)
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

  dispose() {
    _topIds.close();
    _items.close();
  }
}