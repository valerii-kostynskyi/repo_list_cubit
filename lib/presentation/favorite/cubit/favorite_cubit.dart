import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:repo_list_cubit/data/model/repository_model.dart';
import 'package:repo_list_cubit/domain/repository/favorite_rpository.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteRepository favoriteRepository =
      GetIt.instance.get<FavoriteRepository>();

  FavoriteCubit() : super(FavoriteInitialState()) {
    getFavoriteList();
  }

  Future<void> getFavoriteList() async {
    emit(FavoriteLoadingState());
    try {
      final List<RepositoryModel> favoriteRepoList =
          await favoriteRepository.getFavoritesList();
      if (favoriteRepoList.isNotEmpty) {
        emit(FavoriteLoadedState(favoriteRepoList));
      } else {
        emit(FavoriteEmptyState());
      }
    } catch (e) {
      emit(FavoriteErrorState());
    }
  }

  void removeFromFavorites(RepositoryModel repository) {
    favoriteRepository.removeFromFavorites(repository);

    final List<RepositoryModel> updatedRepoList = (state as FavoriteLoadedState)
        .repoList
        .where((repo) => repo.id != repository.id)
        .toList();

    emit(FavoriteLoadedState(updatedRepoList));
  }
}
