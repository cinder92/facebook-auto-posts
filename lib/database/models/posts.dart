import 'package:drift/drift.dart';
import 'package:facebook_auto_posts/database/schema.dart';
import 'package:facebook_auto_posts/main.dart';

@DataClassName('Posts')
class PostsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get content => text()();
  TextColumn get files => text().nullable()();
}

abstract class PostsView extends View {
  PostsTable get postsTable;

  Expression<int> get itemCount => postsTable.id.count();

  @override
  Query as() => select([
        postsTable.id,
        postsTable.name,
        postsTable.content,
        postsTable.files,
      ]).from(postsTable);
}

class PostsModel {
  Future<void> createPost({
    required String name,
    required String content,
    String? files,
  }) async {
    await database.into(database.postsTable).insert(
          PostsTableCompanion.insert(
            name: name,
            content: content,
            files: Value(files),
          ),
        );
  }

  Future<void> deletePost({required Posts post}) async {
    await database.delete(database.postsTable).delete(post);
  }

  Stream<List<Posts>> getAll() => database.select(database.postsTable).watch();
}
