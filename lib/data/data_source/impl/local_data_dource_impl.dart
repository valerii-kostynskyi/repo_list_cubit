import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:repo_list_cubit/data/data_source/local_data_source.dart';
import 'package:repo_list_cubit/data/db_adapter/repository_model_adapter.dart';
import 'package:repo_list_cubit/data/model/repository_model.dart';

class LocalDataSourceImpl extends LocalDataSource {
  static const String _favorites = 'Favorites';
  static const String _searchHistory = 'SearchHistory';

  final StreamController<int> _favoritesStreamController =
      StreamController<int>.broadcast();

  Box<RepositoryModel>? _favoritesBox;
  Box<String>? _searchHistoryBox;

  @override
  Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(RepositoryModelAdapter());
    _favoritesBox = await Hive.openBox<RepositoryModel>(_favorites);
    _favoritesBox!.watch().listen((event) {
      _favoritesStreamController.add(event.key as int);
    });
    _searchHistoryBox = await Hive.openBox<String>(_searchHistory);
  }

  void dispose() {
    _favoritesStreamController.close();
  }

  @override
  Future<List<RepositoryModel>> getFavoritesList() async {
    _favoritesBox = await Hive.openBox<RepositoryModel>(_favorites);
    return _favoritesBox?.values.toList() ?? [];
  }

  @override
  Future<void> addToFavorites(RepositoryModel repository) async {
    _favoritesBox = await Hive.openBox<RepositoryModel>(_favorites);

    if (_favoritesBox != null) {
      await _favoritesBox!.put(repository.id, repository);
    }
  }

  @override
  Future<void> removeFromFavorites(RepositoryModel repository) async {
    _favoritesBox = await Hive.openBox<RepositoryModel>(_favorites);

    if (_favoritesBox != null) {
      final keys = _favoritesBox!.keys;
      final keyToDelete = keys.firstWhere(
        (key) => _favoritesBox!.get(key)?.id == repository.id,
        orElse: () => null,
      );

      if (keyToDelete != null) {
        await _favoritesBox!.delete(keyToDelete);
      }
    }
  }

  @override
  Future<List<String>> getSearchHistory() async {
    _searchHistoryBox = await Hive.openBox<String>(_searchHistory);
    return _searchHistoryBox?.values.toList() ?? [];
  }

  @override
  Future<void> addToSearchHistory(String searchQuery) async {
    _searchHistoryBox = await Hive.openBox<String>(_searchHistory);

    if (_searchHistoryBox != null) {
      final historyList = _searchHistoryBox!.values.toList();
      historyList.remove(searchQuery);
      historyList.insert(0, searchQuery);

      if (historyList.length > 5) {
        historyList.removeLast();
      }

      await _searchHistoryBox!.clear();
      await _searchHistoryBox!.addAll(historyList);
    }
  }

  @override
  Future<void> clearSearchHistory() async {
    _searchHistoryBox = await Hive.openBox<String>(_searchHistory);

    if (_searchHistoryBox != null) {
      await _searchHistoryBox!.clear();
    }
  }

  @override
  Stream<int> get favoriteChanges => _favoritesStreamController.stream;
}
