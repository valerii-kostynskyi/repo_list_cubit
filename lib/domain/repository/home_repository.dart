import 'package:repo_list_cubit/data/model/repository_model.dart';

abstract class HomeRepository {
  Future<List<RepositoryModel>> getRepositoriesList({
    required int page,
    required String query,
  });

  Future<void> addToSearchHistory({required String query});

  Future<List<String>> getSearchHistory();

  Future<void> clearSearchHistory();
}
