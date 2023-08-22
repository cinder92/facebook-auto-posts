import 'package:drift/drift.dart';
import 'package:facebook_auto_posts/database/schema.dart';
import 'package:facebook_auto_posts/main.dart';

@DataClassName('Accounts')
class AccountsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get email => text()();
  TextColumn get password => text()();
}

abstract class AccountsView extends View {
  AccountsTable get accountsTable;

  Expression<int> get itemCount => accountsTable.id.count();

  @override
  Query as() => select([
        accountsTable.id,
        accountsTable.name,
        accountsTable.email,
        accountsTable.password
      ]).from(accountsTable);

  getAll() {
    return select([
      accountsTable.id,
      accountsTable.name,
      accountsTable.email,
      accountsTable.password,
    ]).from(accountsTable);
  }
}

class AccountModel {
  Future<void> createAccount({
    required String name,
    required String email,
    required String password,
  }) async {
    await database.into(database.accountsTable).insert(
          AccountsTableCompanion.insert(
            name: name,
            email: email,
            password: password,
          ),
        );
  }

  Future<void> deleteAccount({required Accounts acc}) async {
    await database.delete(database.accountsTable).delete(acc);
  }

  Stream<List<Accounts>> getAll() =>
      database.select(database.accountsTable).watch();
}
