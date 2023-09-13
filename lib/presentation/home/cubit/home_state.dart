// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitialState extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadingState extends HomeState {
  final List<RepositoryModel> oldRepoList;
  final bool isFirstLoading;

  const HomeLoadingState(this.oldRepoList, {this.isFirstLoading = false});
  @override
  List<Object> get props => [oldRepoList, isFirstLoading];
}

class HomeLoadedState extends HomeState {
  final List<RepositoryModel> repoList;

  const HomeLoadedState(this.repoList);

  @override
  List<Object> get props => [repoList];
}

class HomeEmptyState extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeErrorState extends HomeState {
  @override
  List<Object> get props => [];
}
