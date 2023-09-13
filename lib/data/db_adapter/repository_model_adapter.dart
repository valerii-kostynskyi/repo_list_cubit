import 'package:hive/hive.dart';
import 'package:repo_list_cubit/data/model/repository_model.dart';

class RepositoryModelAdapter extends TypeAdapter<RepositoryModel> {
  @override
  final int typeId = 1;

  @override
  RepositoryModel read(BinaryReader reader) {
    final id = reader.readInt();
    final name = reader.readString();
    final description = reader.readString();
    final stargazersCount = reader.readInt();
    final isFavorite = reader.readBool();

    return RepositoryModel(
      id: id,
      name: name,
      description: description,
      stargazersCount: stargazersCount,
      isFavorite: isFavorite,
    );
  }

  @override
  void write(BinaryWriter writer, RepositoryModel obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.name);
    writer.writeString(obj.description);
    writer.writeInt(obj.stargazersCount);
    writer.writeBool(obj.isFavorite);
  }
}
