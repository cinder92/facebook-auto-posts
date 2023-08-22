import 'package:drift/drift.dart';
import 'package:facebook_auto_posts/database/schema.dart';
import 'package:facebook_auto_posts/main.dart';
import 'package:facebook_auto_posts/types/loggerTypes.dart';

@DataClassName('Logger')
class LoggerTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get type => text()();
  DateTimeColumn get date => dateTime()();
}

abstract class LoggerView extends View {
  LoggerTable get loggerTable;

  Expression<int> get itemCount => loggerTable.id.count();

  @override
  Query as() => select([
        loggerTable.id,
        loggerTable.name,
        loggerTable.type,
        loggerTable.date,
      ]).from(loggerTable);
}

class LoggerModel {
  Future<void> addLog(String name, LoggType type) async {
    await database.into(database.loggerTable).insert(
          LoggerTableCompanion.insert(
            name: name,
            type: logsType[type].toString(),
            date: DateTime.now(),
          ),
        );
  }

  Future<void> clear() async {
    await database.delete(database.loggerTable).go();
  }

  Stream<List<Logger>> getAll() =>
      database.select(database.loggerTable).watch();
}
