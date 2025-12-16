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
    final base = await getDatabasesPath();
    final dbPath = p.join(base, _dbName);

    _db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, _) async {
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
  Future<AppState> loadInitial() async {
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
    final map = <String, int>{
      for (final row in settingsRows) row['key'] as String: row['value'] as int,
    };

    final isDarkMode = (map['isDarkMode'] ?? 0) == 1;
    final asks = (map['asksForDeletionConfirmation'] ?? 1) == 1;

    return AppState(
      todos: todos,
      isDarkMode: isDarkMode,
      asksForDeletionConfirmation: asks,
      selectedTodoIds: const {},
    );
  }

  @override
  Future<void> insertTodo(Todo todo) async {
    final db = await _database();
    await db.insert(_todosTable, {
      'id': todo.id,
      'text': todo.text,
      'is_completed': todo.isCompleted ? 1 : 0,
    });
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    final db = await _database();
    await db.update(
      _todosTable,
      {
        'text': todo.text,
        'is_completed': todo.isCompleted ? 1 : 0,
      },
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  @override
  Future<void> deleteTodos(Set<String> ids) async {
    if (ids.isEmpty) return;
    final db = await _database();

    final placeholders = List.filled(ids.length, '?').join(',');
    await db.delete(
      _todosTable,
      where: 'id IN ($placeholders)',
      whereArgs: ids.toList(),
    );
  }

  @override
  Future<void> saveSettings({
    required bool isDarkMode,
    required bool asksForDeletionConfirmation,
  }) async {
    final db = await _database();

    await db.insert(
      _settingsTable,
      {'key': 'isDarkMode', 'value': isDarkMode ? 1 : 0},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await db.insert(
      _settingsTable,
      {
        'key': 'asksForDeletionConfirmation',
        'value': asksForDeletionConfirmation ? 1 : 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
