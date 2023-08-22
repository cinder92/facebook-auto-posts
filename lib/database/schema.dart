import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:facebook_auto_posts/database/models/accounts.dart';
import 'package:facebook_auto_posts/database/models/groups.dart';
import 'package:facebook_auto_posts/database/models/logger.dart';
import 'package:facebook_auto_posts/database/models/posts.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'schema.g.dart';

@DriftDatabase(tables: [
  AccountsTable,
  GroupsTable,
  PostsTable,
  LoggerTable,
], views: [
  AccountsView,
  GroupsView,
  PostsView,
  LoggerView,
])
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 6;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (to == 6) {
          await m.addColumn(postsTable, postsTable.files);
        }

        await m.createAll();
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app.db'));

    return NativeDatabase.createInBackground(file);
  });
}
