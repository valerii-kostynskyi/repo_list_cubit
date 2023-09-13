import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repo_list_cubit/presentation/components/svg_icon_widget.dart';
import 'package:repo_list_cubit/presentation/home/cubit/home_cubit.dart';
import 'package:repo_list_cubit/presentation/home/widget/home_list_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CUBIT test'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed('/favorites'),
            icon: SVGIconWidget(
              icon: 'icon_star',
              color: Theme.of(context).colorScheme.background,
            ),
          )
        ],
      ),
      body: BlocProvider(
        create: (context) => HomeCubit(),
        child: HomeListView(),
      ),
    );
  }
}
