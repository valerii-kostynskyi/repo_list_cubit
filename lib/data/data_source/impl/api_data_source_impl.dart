import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:repo_list_cubit/data/data_source/api_data_source.dart';
import 'package:repo_list_cubit/data/model/repository_model.dart';

class ApiDataSourceImpl implements ApiDataSource {
  final String apiUrl = 'api.github.com';

  @override
  Future<List<RepositoryModel>> getRepositoriesList({
    required String query,
    required int offset,
  }) async {
    final url = Uri.https(
      apiUrl,
      '/search/repositories',
      {
        'q': query,
        'per_page': '15',
        'page': offset.toString(),
      },
    );

    final response = await http.get(url);
    final jsonData = json.decode(response.body);
    final items =
        jsonData['items'] != null ? jsonData['items'] as List<dynamic> : [];

    return items
        .map<RepositoryModel>((item) => RepositoryModel.fromJson(item))
        .toList();
  }
}
