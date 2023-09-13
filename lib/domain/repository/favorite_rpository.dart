import 'package:repo_list_cubit/data/model/repository_model.dart';

abstract class FavoriteRepository {
  Future<List<RepositoryModel>> getFavoritesList();

  Future<void> addToFavorites(RepositoryModel repository);

  Future<void> removeFromFavorites(RepositoryModel repository);

  Stream<int> get favoriteChanges;
}
