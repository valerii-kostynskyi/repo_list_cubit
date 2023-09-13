import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:repo_list_cubit/data/data_source/api_data_source.dart';
import 'package:repo_list_cubit/data/data_source/impl/api_data_source_impl.dart';
import 'package:repo_list_cubit/data/data_source/impl/local_data_dource_impl.dart';
import 'package:repo_list_cubit/data/data_source/local_data_source.dart';
import 'package:repo_list_cubit/domain/repository/favorite_rpository.dart';
import 'package:repo_list_cubit/domain/repository/home_repository.dart';
import 'package:repo_list_cubit/domain/repository/impl/favorite_repository_impl.dart';
import 'package:repo_list_cubit/domain/repository/impl/home_repository_impl.dart';
import 'package:repo_list_cubit/presentation/detail/detail_page.dart';
import 'package:repo_list_cubit/presentation/favorite/favorite_page.dart';
import 'package:repo_list_cubit/presentation/home/home_page.dart';
import 'package:repo_list_cubit/presentation/style/theme.dart';

void main() {
  GetIt.instance
      .registerSingleton<LocalDataSource>(LocalDataSourceImpl())
      .init();
  GetIt.instance.registerSingleton<ApiDataSource>(ApiDataSourceImpl());
  GetIt.instance.registerSingleton<HomeRepository>(
    HomeRepositoryImpl(
      GetIt.instance.get<ApiDataSource>(),
      GetIt.instance.get<LocalDataSource>(),
    ),
  );
  GetIt.instance.registerSingleton<FavoriteRepository>(
    FavoriteRepositoryImpl(GetIt.instance.get<LocalDataSource>()),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      home: const HomePage(),
      routes: <String, WidgetBuilder>{
        '/favorites': (BuildContext context) => const FavoritePage(),
        '/detail': (BuildContext context) => const DetailPage(),
      },
    );
  }
}
