import 'package:drift/drift.dart';
import 'package:facebook_auto_posts/database/schema.dart';
import 'package:facebook_auto_posts/main.dart';

@DataClassName('Groups')
class GroupsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get url => text()();
}

abstract class GroupsView extends View {
  GroupsTable get groupTable;

  Expression<int> get itemCount => groupTable.id.count();

  @override
  Query as() => select([
        groupTable.id,
        groupTable.name,
      ]).from(groupTable);
}

class GroupsModel {
  Future<void> createGroup({
    required String name,
    required String url,
  }) async {
    await database.into(database.groupsTable).insert(
          GroupsTableCompanion.insert(name: name, url: url),
        );
  }

  Future<void> deleteGroup({required Groups group}) async {
    await database.delete(database.groupsTable).delete(group);
  }

  Stream<List<Groups>> getAll() =>
      database.select(database.groupsTable).watch();
}
