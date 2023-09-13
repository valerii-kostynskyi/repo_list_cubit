import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repo_list_cubit/presentation/components/svg_icon_widget.dart';
import 'package:repo_list_cubit/presentation/favorite/cubit/favorite_cubit.dart';
import 'package:repo_list_cubit/presentation/favorite/widget/favorite_list_view.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite page'),
        leading: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SVGIconWidget(
            icon: 'icon_left',
            onTap: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => FavoriteCubit(),
        child: const FavoriteListView(),
      ),
    );
  }
}
