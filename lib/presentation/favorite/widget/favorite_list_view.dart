import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repo_list_cubit/data/model/repository_model.dart';
import 'package:repo_list_cubit/presentation/components/item_repository_widget.dart';
import 'package:repo_list_cubit/presentation/favorite/cubit/favorite_cubit.dart';

class FavoriteListView extends StatelessWidget {
  const FavoriteListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        if (state is FavoriteLoadingState) {
          return const CircularProgressIndicator();
        } else if (state is FavoriteLoadedState) {
          return _list(state.repoList);
        } else if (state is FavoriteEmptyState) {
          return const Text('FavoriteEmptyState');
        } else if (state is FavoriteErrorState) {
          return const Text('error');
        }
        return Container();
      },
    );
  }

  Widget _list(List<RepositoryModel> repoList) {
    return ListView.builder(
      itemCount: repoList.length,
      itemBuilder: (context, index) => ItemRepositoryWidget(
        repository: repoList[index],
        onTap: () {
          context.read<FavoriteCubit>().removeFromFavorites(repoList[index]);
        },
      ),
    );
  }
}
