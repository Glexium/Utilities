// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  FileCacheDao? _getCacheInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `EFile` (`id` INTEGER, `name` TEXT, `updatedAt` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  FileCacheDao get getCache {
    return _getCacheInstance ??= _$FileCacheDao(database, changeListener);
  }
}

class _$FileCacheDao extends FileCacheDao {
  _$FileCacheDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _eFileInsertionAdapter = InsertionAdapter(
            database,
            'EFile',
            (EFile item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'updatedAt': item.updatedAt
                },
            changeListener),
        _eFileUpdateAdapter = UpdateAdapter(
            database,
            'EFile',
            ['id'],
            (EFile item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'updatedAt': item.updatedAt
                },
            changeListener),
        _eFileDeletionAdapter = DeletionAdapter(
            database,
            'EFile',
            ['id'],
            (EFile item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'updatedAt': item.updatedAt
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<EFile> _eFileInsertionAdapter;

  final UpdateAdapter<EFile> _eFileUpdateAdapter;

  final DeletionAdapter<EFile> _eFileDeletionAdapter;

  @override
  Future<List<EFile>> getFileCache() async {
    return _queryAdapter.queryList('SELECT * FROM EFile',
        mapper: (Map<String, Object?> row) => EFile(row['id'] as int?,
            row['name'] as String?, row['updatedAt'] as String?));
  }

  @override
  Future<EFile?> findFileById(int id) async {
    return _queryAdapter.query('SELECT * FROM EFile WHERE id = ?1',
        mapper: (Map<String, Object?> row) => EFile(row['id'] as int?,
            row['name'] as String?, row['updatedAt'] as String?),
        arguments: [id]);
  }

  @override
  Stream<EFile?> findFileByName(String name) {
    return _queryAdapter.queryStream('SELECT * FROM EFile WHERE name = ?1',
        mapper: (Map<String, Object?> row) => EFile(row['id'] as int?,
            row['name'] as String?, row['updatedAt'] as String?),
        arguments: [name],
        queryableName: 'EFile',
        isView: false);
  }

  @override
  Stream<EFile?> deleteFileById(int id) {
    return _queryAdapter.queryStream('DELETE FROM EFile WHERE id = ?1',
        mapper: (Map<String, Object?> row) => EFile(row['id'] as int?,
            row['name'] as String?, row['updatedAt'] as String?),
        arguments: [id],
        queryableName: 'EFile',
        isView: false);
  }

  @override
  Future<void> insertFile(EFile eFile) async {
    await _eFileInsertionAdapter.insert(eFile, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateFileFromCache(EFile eFile) {
    return _eFileUpdateAdapter.updateAndReturnChangedRows(
        eFile, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteFileFromCache(EFile eFile) {
    return _eFileDeletionAdapter.deleteAndReturnChangedRows(eFile);
  }
}
