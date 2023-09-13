import 'package:repo_list_cubit/data/model/repository_model.dart';

abstract class ApiDataSource {
  Future<List<RepositoryModel>> getRepositoriesList({
    required String query,
    required int offset,
  });
}
