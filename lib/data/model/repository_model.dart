// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:repo_list_cubit/util/json_extension.dart';

class RepositoryModel extends Equatable {
  final int id;
  final String name;
  final String description;
  final int stargazersCount;
  final bool isFavorite;

  const RepositoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.stargazersCount,
    this.isFavorite = false,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      description,
      stargazersCount,
      isFavorite,
    ];
  }

  factory RepositoryModel.fromJson(Map<String, dynamic> json) {
    return RepositoryModel(
      id: json.parseJsonAsInt(key: 'id'),
      name: json.parseJsonAsString(key: 'name'),
      description: json.parseJsonAsString(key: 'description'),
      stargazersCount: json.parseJsonAsInt(key: 'stargazers_count'),
    );
  }

  RepositoryModel copyWith({
    int? id,
    String? name,
    String? description,
    int? stargazersCount,
    bool? isFavorite,
  }) {
    return RepositoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      stargazersCount: stargazersCount ?? this.stargazersCount,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
