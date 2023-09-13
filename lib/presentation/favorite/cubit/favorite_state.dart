part of 'favorite_cubit.dart';

class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteInitialState extends FavoriteState {
  @override
  List<Object> get props => [];
}

class FavoriteLoadingState extends FavoriteState {
  @override
  List<Object> get props => [];
}

class FavoriteLoadedState extends FavoriteState {
  final List<RepositoryModel> repoList;

  const FavoriteLoadedState(this.repoList);

  @override
  List<Object> get props => [repoList];
}

class FavoriteEmptyState extends FavoriteState {
  @override
  List<Object> get props => [];
}

class FavoriteErrorState extends FavoriteState {
  @override
  List<Object> get props => [];
}
