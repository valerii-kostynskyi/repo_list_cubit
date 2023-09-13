import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:repo_list_cubit/data/model/repository_model.dart';
import 'package:repo_list_cubit/domain/repository/favorite_rpository.dart';
import 'package:repo_list_cubit/domain/repository/home_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository homeRepository = GetIt.instance.get<HomeRepository>();
  final FavoriteRepository favoriteRepository =
      GetIt.instance.get<FavoriteRepository>();
  int page = 1;
  List<RepositoryModel> repoList = [];
  String tmpValue = '';
  StreamSubscription<int>? favoritesSubscription;

  HomeCubit() : super(HomeInitialState()) {
    _listenToFavoriteChanges();
  }

  void _listenToFavoriteChanges() {
    favoritesSubscription =
        favoriteRepository.favoriteChanges.listen((int repoId) {
      _updateFavoriteStatusForRepo(repoId);
    });
  }

  Future<void> getRepoList(String searchQwert) async {
    if (state is HomeLoadingState) return;
    if (searchQwert != tmpValue) {
      repoList.clear();
      emit(HomeLoadingState(repoList, isFirstLoading: page == 1));
    }

    if (state is HomeLoadedState) {
      repoList = (state as HomeLoadedState).repoList;
    }

    emit(HomeLoadingState(repoList, isFirstLoading: page == 1));

    try {
      final List<RepositoryModel> newRepoList = await homeRepository
          .getRepositoriesList(page: page, query: searchQwert);

      if (newRepoList.isEmpty && repoList.isEmpty) {
        emit(HomeEmptyState());
        return;
      }

      page++;

      final List<RepositoryModel> updatedRepolist =
          (state as HomeLoadingState).oldRepoList;
      updatedRepolist.addAll(newRepoList);
      tmpValue = searchQwert;
      emit(HomeLoadedState(updatedRepolist));
    } catch (e) {
      emit(HomeErrorState());
    }
  }

  void toggleFavoriteRepo(RepositoryModel repository) {
    RepositoryModel updatedRepository =
        repository.copyWith(isFavorite: !repository.isFavorite);
    if (repository.isFavorite) {
      favoriteRepository.removeFromFavorites(updatedRepository);
    } else {
      favoriteRepository.addToFavorites(updatedRepository);
    }
  }

  void _updateFavoriteStatusForRepo(int repoId) {
    if (state is HomeLoadedState) {
      final currentList = (state as HomeLoadedState).repoList;
      final repoIndex = currentList.indexWhere((repo) => repo.id == repoId);

      if (repoIndex != -1) {
        bool currentStatus = currentList[repoIndex].isFavorite;
        final updatedRepo =
            currentList[repoIndex].copyWith(isFavorite: !currentStatus);
        final updatedList = List<RepositoryModel>.from(currentList)
          ..[repoIndex] = updatedRepo;

        emit(HomeLoadedState(updatedList));
      }
    }
  }
}
