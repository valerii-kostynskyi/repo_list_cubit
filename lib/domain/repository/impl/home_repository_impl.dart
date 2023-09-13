import 'package:repo_list_cubit/data/data_source/api_data_source.dart';
import 'package:repo_list_cubit/data/data_source/local_data_source.dart';
import 'package:repo_list_cubit/data/model/repository_model.dart';
import 'package:repo_list_cubit/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final ApiDataSource _apiDataSource;
  final LocalDataSource _localDataSource;

  HomeRepositoryImpl(
    this._apiDataSource,
    this._localDataSource,
  );

  @override
  Future<List<RepositoryModel>> getRepositoriesList({
    required String query,
    required int page,
  }) async {
    List<RepositoryModel> favoriteList =
        await _localDataSource.getFavoritesList();
    List<RepositoryModel> networkList =
        await _apiDataSource.getRepositoriesList(
      query: query,
      offset: page,
    );
    for (int i = 0; i < networkList.length; i++) {
      for (RepositoryModel favRepo in favoriteList) {
        if (networkList[i].id == favRepo.id) {
          networkList[i] = networkList[i].copyWith(isFavorite: true);
          break;
        }
      }
    }

    return networkList;
  }

  @override
  Future<List<String>> getSearchHistory() async {
    return _localDataSource.getSearchHistory();
  }

  @override
  Future<void> addToSearchHistory({required String query}) async {
    await _localDataSource.addToSearchHistory(query);
  }

  @override
  Future<void> clearSearchHistory() async {
    await _localDataSource.clearSearchHistory();
  }
}
