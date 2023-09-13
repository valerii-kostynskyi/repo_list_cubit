import 'package:repo_list_cubit/data/data_source/local_data_source.dart';
import 'package:repo_list_cubit/data/model/repository_model.dart';
import 'package:repo_list_cubit/domain/repository/favorite_rpository.dart';

class FavoriteRepositoryImpl extends FavoriteRepository {
  final LocalDataSource _localDataSource;

  FavoriteRepositoryImpl(
    this._localDataSource,
  );

  @override
  Future<List<RepositoryModel>> getFavoritesList() async {
    return _localDataSource.getFavoritesList();
  }

  @override
  Future addToFavorites(RepositoryModel repository) async {
    await _localDataSource.addToFavorites(repository);
  }

  @override
  Future removeFromFavorites(RepositoryModel repository) async {
    await _localDataSource.removeFromFavorites(repository);
  }

  @override
  Stream<int> get favoriteChanges => _localDataSource.favoriteChanges;
}
