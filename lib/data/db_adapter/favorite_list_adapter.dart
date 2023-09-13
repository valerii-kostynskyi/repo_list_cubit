import 'package:hive/hive.dart';
import 'package:repo_list_cubit/data/model/repository_model.dart';

class FavoriteListAdapter extends TypeAdapter<List<RepositoryModel>> {
  @override
  final int typeId = 0;

  @override
  List<RepositoryModel> read(BinaryReader reader) {
    final length = reader.readInt();
    final list = List<RepositoryModel>.generate(length, (_) => reader.read());
    return list;
  }

  @override
  void write(BinaryWriter writer, List<RepositoryModel> obj) {
    writer.writeInt(obj.length);
    obj.forEach(writer.write);
  }
}
