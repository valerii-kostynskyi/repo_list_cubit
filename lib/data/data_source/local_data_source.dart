import 'package:repo_list_cubit/data/model/repository_model.dart';

abstract class LocalDataSource {
  Future init();

  Future<List<RepositoryModel>> getFavoritesList();

  Future addToFavorites(RepositoryModel repository);

  Future removeFromFavorites(RepositoryModel repository);

  Future<List<String>> getSearchHistory();

  Future<void> addToSearchHistory(String searchQuery);

  Future<void> clearSearchHistory();

  Stream<int> get favoriteChanges;
}
