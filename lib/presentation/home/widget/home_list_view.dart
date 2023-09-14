import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repo_list_cubit/data/model/repository_model.dart';
import 'package:repo_list_cubit/presentation/components/circular_widget.dart';
import 'package:repo_list_cubit/presentation/components/input_text_field_widget.dart';
import 'package:repo_list_cubit/presentation/components/item_repository_widget.dart';
import 'package:repo_list_cubit/presentation/detail/detail_page.dart';
import 'package:repo_list_cubit/presentation/home/cubit/home_cubit.dart';

class HomeListView extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  HomeListView({Key? key}) : super(key: key);

  void _setupScrollController(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge &&
          _scrollController.position.pixels != 0) {
        BlocProvider.of<HomeCubit>(context).getRepoList(_searchController.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _setupScrollController(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InputTextFieldWidget(
            controller: _searchController,
            onTapSuffix: () {
              BlocProvider.of<HomeCubit>(context)
                  .getRepoList(_searchController.text);
            },
          ),
        ),
        Expanded(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeLoadingState && state.isFirstLoading) {
                return const CircularIndicator();
              }
              if (state is HomeLoadingState) {
                return _list(
                  list: state.oldRepoList,
                  isLoading: true,
                );
              } else if (state is HomeLoadedState) {
                return _list(list: state.repoList);
              }
              if (state is HomeEmptyState) {
                return const Center(child: Text("Нічого не знайдено"));
              }
              if (state is HomeErrorState) {
                return const Text('Помилка завантаження');
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _list({
    required List<RepositoryModel> list,
    bool isLoading = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        controller: _scrollController,
        itemCount: list.length + (isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < list.length) {
            return ItemRepositoryWidget(
              repository: list[index],
              onIconTap: () {
                context.read<HomeCubit>().toggleFavoriteRepo(list[index]);
              },
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailPage(repository: list[index]),
                ),
              ),
            );
          } else {
            return const CircularIndicator();
          }
        },
      ),
    );
  }
}
