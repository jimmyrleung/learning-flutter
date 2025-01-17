import 'package:news/src/blocs/comments_provider.dart';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/news_repository.dart';

class CommentsBloc {
  final _repository = NewsRepository();
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  // Streams
  Observable<Map<int, Future<ItemModel>>> get itemWithComments =>
      _commentsOutput.stream;

  // Sink
  Function(int) get fetchItemWithComments => _commentsFetcher.sink.add;

  CommentsBloc() {
    _commentsFetcher.stream
        .transform(_commentsTransformer())
        .pipe(_commentsOutput);
  }

  _commentsTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
      (cache, int id, index) {
        cache[id] = _repository.fetchItem(id);

        cache[id].then((ItemModel item) {
          item.kids.forEach((kidId) {
            print(kidId.toString());
            return fetchItemWithComments(kidId);
          });
        });

        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }
}
