import 'package:i12_into_012/models/app_state.dart';
import 'package:i12_into_012/models/todo.dart';
import 'package:i12_into_012/services/app_state_storage.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class SqliteAppStateStorage implements AppStateStorage {
  static const _dbName = 'todo_app.db';
  static const _todosTable = 'todos';
  static const _settingsTable = 'settings';

  Database? _db;

  Future<Database> _database() async {
    if (_db != null) return _db!;
    final basePath = await getDatabasesPath();
    final dbPath = p.join(basePath, _dbName);

    _db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_todosTable(
            id TEXT PRIMARY KEY,
            text TEXT NOT NULL,
            is_completed INTEGER NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE $_settingsTable(
            key TEXT PRIMARY KEY,
            value INTEGER NOT NULL
          )
        ''');

        await db.insert(_settingsTable, {'key': 'isDarkMode', 'value': 0});
        await db.insert(_settingsTable, {
          'key': 'asksForDeletionConfirmation',
          'value': 1,
        });
      },
    );

    return _db!;
  }

  @override
  Future<AppState?> load() async {
    try {
      final db = await _database();

      final todoRows = await db.query(_todosTable, orderBy: 'rowid ASC');
      final todos = todoRows.map((r) {
        return Todo(
          id: r['id'] as String,
          text: r['text'] as String,
          isCompleted: (r['is_completed'] as int) == 1,
        );
      }).toList();

      final settingsRows = await db.query(_settingsTable);
      final settings = <String, int>{
        for (final row in settingsRows)
          row['key'] as String: row['value'] as int,
      };

      final isDarkMode = (settings['isDarkMode'] ?? 0) == 1;
      final asks = (settings['asksForDeletionConfirmation'] ?? 1) == 1;

      return AppState(
        todos: todos,
        isDarkMode: isDarkMode,
        asksForDeletionConfirmation: asks,
        selectedTodoIds: const {},
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> save(AppState state) async {
    final db = await _database();

    await db.transaction((txn) async {
      await txn.delete(_todosTable);

      for (final t in state.todos) {
        await txn.insert(_todosTable, {
          'id': t.id,
          'text': t.text,
          'is_completed': t.isCompleted ? 1 : 0,
        });
      }

      await txn.insert(
        _settingsTable,
        {'key': 'isDarkMode', 'value': state.isDarkMode ? 1 : 0},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      await txn.insert(
        _settingsTable,
        {
          'key': 'asksForDeletionConfirmation',
          'value': state.asksForDeletionConfirmation ? 1 : 0,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }
}
