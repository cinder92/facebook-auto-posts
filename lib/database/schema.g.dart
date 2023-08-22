// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schema.dart';

// ignore_for_file: type=lint
class $AccountsTableTable extends AccountsTable
    with TableInfo<$AccountsTableTable, Accounts> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _passwordMeta =
      const VerificationMeta('password');
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
      'password', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, email, password];
  @override
  String get aliasedName => _alias ?? 'accounts_table';
  @override
  String get actualTableName => 'accounts_table';
  @override
  VerificationContext validateIntegrity(Insertable<Accounts> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Accounts map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Accounts(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      password: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password'])!,
    );
  }

  @override
  $AccountsTableTable createAlias(String alias) {
    return $AccountsTableTable(attachedDatabase, alias);
  }
}

class Accounts extends DataClass implements Insertable<Accounts> {
  final int id;
  final String name;
  final String email;
  final String password;
  const Accounts(
      {required this.id,
      required this.name,
      required this.email,
      required this.password});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['email'] = Variable<String>(email);
    map['password'] = Variable<String>(password);
    return map;
  }

  AccountsTableCompanion toCompanion(bool nullToAbsent) {
    return AccountsTableCompanion(
      id: Value(id),
      name: Value(name),
      email: Value(email),
      password: Value(password),
    );
  }

  factory Accounts.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Accounts(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      password: serializer.fromJson<String>(json['password']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'password': serializer.toJson<String>(password),
    };
  }

  Accounts copyWith({int? id, String? name, String? email, String? password}) =>
      Accounts(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
      );
  @override
  String toString() {
    return (StringBuffer('Accounts(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('password: $password')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, email, password);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Accounts &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.password == this.password);
}

class AccountsTableCompanion extends UpdateCompanion<Accounts> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> email;
  final Value<String> password;
  const AccountsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.password = const Value.absent(),
  });
  AccountsTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String email,
    required String password,
  })  : name = Value(name),
        email = Value(email),
        password = Value(password);
  static Insertable<Accounts> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? password,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
    });
  }

  AccountsTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? email,
      Value<String>? password}) {
    return AccountsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('password: $password')
          ..write(')'))
        .toString();
  }
}

class $GroupsTableTable extends GroupsTable
    with TableInfo<$GroupsTableTable, Groups> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GroupsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, url];
  @override
  String get aliasedName => _alias ?? 'groups_table';
  @override
  String get actualTableName => 'groups_table';
  @override
  VerificationContext validateIntegrity(Insertable<Groups> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Groups map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Groups(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url'])!,
    );
  }

  @override
  $GroupsTableTable createAlias(String alias) {
    return $GroupsTableTable(attachedDatabase, alias);
  }
}

class Groups extends DataClass implements Insertable<Groups> {
  final int id;
  final String name;
  final String url;
  const Groups({required this.id, required this.name, required this.url});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['url'] = Variable<String>(url);
    return map;
  }

  GroupsTableCompanion toCompanion(bool nullToAbsent) {
    return GroupsTableCompanion(
      id: Value(id),
      name: Value(name),
      url: Value(url),
    );
  }

  factory Groups.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Groups(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      url: serializer.fromJson<String>(json['url']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'url': serializer.toJson<String>(url),
    };
  }

  Groups copyWith({int? id, String? name, String? url}) => Groups(
        id: id ?? this.id,
        name: name ?? this.name,
        url: url ?? this.url,
      );
  @override
  String toString() {
    return (StringBuffer('Groups(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('url: $url')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, url);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Groups &&
          other.id == this.id &&
          other.name == this.name &&
          other.url == this.url);
}

class GroupsTableCompanion extends UpdateCompanion<Groups> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> url;
  const GroupsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.url = const Value.absent(),
  });
  GroupsTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String url,
  })  : name = Value(name),
        url = Value(url);
  static Insertable<Groups> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? url,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (url != null) 'url': url,
    });
  }

  GroupsTableCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<String>? url}) {
    return GroupsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GroupsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('url: $url')
          ..write(')'))
        .toString();
  }
}

class $PostsTableTable extends PostsTable
    with TableInfo<$PostsTableTable, Posts> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PostsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _filesMeta = const VerificationMeta('files');
  @override
  late final GeneratedColumn<String> files = GeneratedColumn<String>(
      'files', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, name, content, files];
  @override
  String get aliasedName => _alias ?? 'posts_table';
  @override
  String get actualTableName => 'posts_table';
  @override
  VerificationContext validateIntegrity(Insertable<Posts> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('files')) {
      context.handle(
          _filesMeta, files.isAcceptableOrUnknown(data['files']!, _filesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Posts map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Posts(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      files: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}files']),
    );
  }

  @override
  $PostsTableTable createAlias(String alias) {
    return $PostsTableTable(attachedDatabase, alias);
  }
}

class Posts extends DataClass implements Insertable<Posts> {
  final int id;
  final String name;
  final String content;
  final String? files;
  const Posts(
      {required this.id,
      required this.name,
      required this.content,
      this.files});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || files != null) {
      map['files'] = Variable<String>(files);
    }
    return map;
  }

  PostsTableCompanion toCompanion(bool nullToAbsent) {
    return PostsTableCompanion(
      id: Value(id),
      name: Value(name),
      content: Value(content),
      files:
          files == null && nullToAbsent ? const Value.absent() : Value(files),
    );
  }

  factory Posts.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Posts(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      content: serializer.fromJson<String>(json['content']),
      files: serializer.fromJson<String?>(json['files']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'content': serializer.toJson<String>(content),
      'files': serializer.toJson<String?>(files),
    };
  }

  Posts copyWith(
          {int? id,
          String? name,
          String? content,
          Value<String?> files = const Value.absent()}) =>
      Posts(
        id: id ?? this.id,
        name: name ?? this.name,
        content: content ?? this.content,
        files: files.present ? files.value : this.files,
      );
  @override
  String toString() {
    return (StringBuffer('Posts(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('content: $content, ')
          ..write('files: $files')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, content, files);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Posts &&
          other.id == this.id &&
          other.name == this.name &&
          other.content == this.content &&
          other.files == this.files);
}

class PostsTableCompanion extends UpdateCompanion<Posts> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> content;
  final Value<String?> files;
  const PostsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.content = const Value.absent(),
    this.files = const Value.absent(),
  });
  PostsTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String content,
    this.files = const Value.absent(),
  })  : name = Value(name),
        content = Value(content);
  static Insertable<Posts> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? content,
    Expression<String>? files,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (content != null) 'content': content,
      if (files != null) 'files': files,
    });
  }

  PostsTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? content,
      Value<String?>? files}) {
    return PostsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      content: content ?? this.content,
      files: files ?? this.files,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (files.present) {
      map['files'] = Variable<String>(files.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PostsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('content: $content, ')
          ..write('files: $files')
          ..write(')'))
        .toString();
  }
}

class $LoggerTableTable extends LoggerTable
    with TableInfo<$LoggerTableTable, Logger> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LoggerTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, type, date];
  @override
  String get aliasedName => _alias ?? 'logger_table';
  @override
  String get actualTableName => 'logger_table';
  @override
  VerificationContext validateIntegrity(Insertable<Logger> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Logger map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Logger(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
    );
  }

  @override
  $LoggerTableTable createAlias(String alias) {
    return $LoggerTableTable(attachedDatabase, alias);
  }
}

class Logger extends DataClass implements Insertable<Logger> {
  final int id;
  final String name;
  final String type;
  final DateTime date;
  const Logger(
      {required this.id,
      required this.name,
      required this.type,
      required this.date});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  LoggerTableCompanion toCompanion(bool nullToAbsent) {
    return LoggerTableCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      date: Value(date),
    );
  }

  factory Logger.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Logger(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  Logger copyWith({int? id, String? name, String? type, DateTime? date}) =>
      Logger(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('Logger(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, type, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Logger &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.date == this.date);
}

class LoggerTableCompanion extends UpdateCompanion<Logger> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> type;
  final Value<DateTime> date;
  const LoggerTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.date = const Value.absent(),
  });
  LoggerTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String type,
    required DateTime date,
  })  : name = Value(name),
        type = Value(type),
        date = Value(date);
  static Insertable<Logger> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (date != null) 'date': date,
    });
  }

  LoggerTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? type,
      Value<DateTime>? date}) {
    return LoggerTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LoggerTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class AccountsViewData extends DataClass {
  final int id;
  final String name;
  final String email;
  final String password;
  const AccountsViewData(
      {required this.id,
      required this.name,
      required this.email,
      required this.password});
  factory AccountsViewData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountsViewData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      password: serializer.fromJson<String>(json['password']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'password': serializer.toJson<String>(password),
    };
  }

  AccountsViewData copyWith(
          {int? id, String? name, String? email, String? password}) =>
      AccountsViewData(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
      );
  @override
  String toString() {
    return (StringBuffer('AccountsViewData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('password: $password')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, email, password);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountsViewData &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.password == this.password);
}

class $AccountsViewView extends ViewInfo<$AccountsViewView, AccountsViewData>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$Database attachedDatabase;
  $AccountsViewView(this.attachedDatabase, [this._alias]);
  $AccountsTableTable get accountsTable =>
      attachedDatabase.accountsTable.createAlias('t0');
  @override
  List<GeneratedColumn> get $columns => [id, name, email, password];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'accounts_view';
  @override
  String? get createViewStmt => null;
  @override
  $AccountsViewView get asDslTable => this;
  @override
  AccountsViewData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountsViewData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      password: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password'])!,
    );
  }

  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      generatedAs: GeneratedAs(accountsTable.id, false),
      type: DriftSqlType.int);
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      generatedAs: GeneratedAs(accountsTable.name, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      generatedAs: GeneratedAs(accountsTable.email, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
      'password', aliasedName, false,
      generatedAs: GeneratedAs(accountsTable.password, false),
      type: DriftSqlType.string);
  @override
  $AccountsViewView createAlias(String alias) {
    return $AccountsViewView(attachedDatabase, alias);
  }

  @override
  Query? get query =>
      (attachedDatabase.selectOnly(accountsTable)..addColumns($columns));
  @override
  Set<String> get readTables => const {'accounts_table'};
}

class GroupsViewData extends DataClass {
  final int id;
  final String name;
  const GroupsViewData({required this.id, required this.name});
  factory GroupsViewData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GroupsViewData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  GroupsViewData copyWith({int? id, String? name}) => GroupsViewData(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('GroupsViewData(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GroupsViewData &&
          other.id == this.id &&
          other.name == this.name);
}

class $GroupsViewView extends ViewInfo<$GroupsViewView, GroupsViewData>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$Database attachedDatabase;
  $GroupsViewView(this.attachedDatabase, [this._alias]);
  $GroupsTableTable get groupTable =>
      attachedDatabase.groupsTable.createAlias('t0');
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'groups_view';
  @override
  String? get createViewStmt => null;
  @override
  $GroupsViewView get asDslTable => this;
  @override
  GroupsViewData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GroupsViewData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      generatedAs: GeneratedAs(groupTable.id, false), type: DriftSqlType.int);
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      generatedAs: GeneratedAs(groupTable.name, false),
      type: DriftSqlType.string);
  @override
  $GroupsViewView createAlias(String alias) {
    return $GroupsViewView(attachedDatabase, alias);
  }

  @override
  Query? get query =>
      (attachedDatabase.selectOnly(groupTable)..addColumns($columns));
  @override
  Set<String> get readTables => const {'groups_table'};
}

class PostsViewData extends DataClass {
  final int id;
  final String name;
  final String content;
  final String? files;
  const PostsViewData(
      {required this.id,
      required this.name,
      required this.content,
      this.files});
  factory PostsViewData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PostsViewData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      content: serializer.fromJson<String>(json['content']),
      files: serializer.fromJson<String?>(json['files']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'content': serializer.toJson<String>(content),
      'files': serializer.toJson<String?>(files),
    };
  }

  PostsViewData copyWith(
          {int? id,
          String? name,
          String? content,
          Value<String?> files = const Value.absent()}) =>
      PostsViewData(
        id: id ?? this.id,
        name: name ?? this.name,
        content: content ?? this.content,
        files: files.present ? files.value : this.files,
      );
  @override
  String toString() {
    return (StringBuffer('PostsViewData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('content: $content, ')
          ..write('files: $files')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, content, files);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PostsViewData &&
          other.id == this.id &&
          other.name == this.name &&
          other.content == this.content &&
          other.files == this.files);
}

class $PostsViewView extends ViewInfo<$PostsViewView, PostsViewData>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$Database attachedDatabase;
  $PostsViewView(this.attachedDatabase, [this._alias]);
  $PostsTableTable get postsTable =>
      attachedDatabase.postsTable.createAlias('t0');
  @override
  List<GeneratedColumn> get $columns => [id, name, content, files];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'posts_view';
  @override
  String? get createViewStmt => null;
  @override
  $PostsViewView get asDslTable => this;
  @override
  PostsViewData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PostsViewData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      files: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}files']),
    );
  }

  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      generatedAs: GeneratedAs(postsTable.id, false), type: DriftSqlType.int);
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      generatedAs: GeneratedAs(postsTable.name, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      generatedAs: GeneratedAs(postsTable.content, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<String> files = GeneratedColumn<String>(
      'files', aliasedName, true,
      generatedAs: GeneratedAs(postsTable.files, false),
      type: DriftSqlType.string);
  @override
  $PostsViewView createAlias(String alias) {
    return $PostsViewView(attachedDatabase, alias);
  }

  @override
  Query? get query =>
      (attachedDatabase.selectOnly(postsTable)..addColumns($columns));
  @override
  Set<String> get readTables => const {'posts_table'};
}

class LoggerViewData extends DataClass {
  final int id;
  final String name;
  final String type;
  final DateTime date;
  const LoggerViewData(
      {required this.id,
      required this.name,
      required this.type,
      required this.date});
  factory LoggerViewData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LoggerViewData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  LoggerViewData copyWith(
          {int? id, String? name, String? type, DateTime? date}) =>
      LoggerViewData(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('LoggerViewData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, type, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoggerViewData &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.date == this.date);
}

class $LoggerViewView extends ViewInfo<$LoggerViewView, LoggerViewData>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$Database attachedDatabase;
  $LoggerViewView(this.attachedDatabase, [this._alias]);
  $LoggerTableTable get loggerTable =>
      attachedDatabase.loggerTable.createAlias('t0');
  @override
  List<GeneratedColumn> get $columns => [id, name, type, date];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'logger_view';
  @override
  String? get createViewStmt => null;
  @override
  $LoggerViewView get asDslTable => this;
  @override
  LoggerViewData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LoggerViewData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
    );
  }

  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      generatedAs: GeneratedAs(loggerTable.id, false), type: DriftSqlType.int);
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      generatedAs: GeneratedAs(loggerTable.name, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      generatedAs: GeneratedAs(loggerTable.type, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      generatedAs: GeneratedAs(loggerTable.date, false),
      type: DriftSqlType.dateTime);
  @override
  $LoggerViewView createAlias(String alias) {
    return $LoggerViewView(attachedDatabase, alias);
  }

  @override
  Query? get query =>
      (attachedDatabase.selectOnly(loggerTable)..addColumns($columns));
  @override
  Set<String> get readTables => const {'logger_table'};
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  late final $AccountsTableTable accountsTable = $AccountsTableTable(this);
  late final $GroupsTableTable groupsTable = $GroupsTableTable(this);
  late final $PostsTableTable postsTable = $PostsTableTable(this);
  late final $LoggerTableTable loggerTable = $LoggerTableTable(this);
  late final $AccountsViewView accountsView = $AccountsViewView(this);
  late final $GroupsViewView groupsView = $GroupsViewView(this);
  late final $PostsViewView postsView = $PostsViewView(this);
  late final $LoggerViewView loggerView = $LoggerViewView(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        accountsTable,
        groupsTable,
        postsTable,
        loggerTable,
        accountsView,
        groupsView,
        postsView,
        loggerView
      ];
}
