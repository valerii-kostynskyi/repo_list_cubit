import 'package:flutter/material.dart';
import 'package:repo_list_cubit/data/model/repository_model.dart';
import 'package:repo_list_cubit/presentation/components/svg_icon_widget.dart';

class DetailPage extends StatelessWidget {
  final RepositoryModel repository;

  const DetailPage({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(repository.name),
        leading: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SVGIconWidget(
              icon: 'icon_left',
              onTap: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ),
      body: Hero(
        tag: 'item_${repository.id}',
        child: Material(
          child: ListView(
            children: [
              Text(repository.name),
              Text(repository.description),
              Text(repository.stargazersCount.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
