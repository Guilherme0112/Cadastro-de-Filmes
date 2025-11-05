import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _db;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB('filmes.db');
    return _db!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE filmes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        url TEXT,
        title TEXT,
        genre TEXT,
        duration TEXT,
        rating REAL,
        age TEXT,
        year TEXT,
        description TEXT
      )
    ''');
  }

  Future<int> save(Map<String, dynamic> filme) async {
    final db = await instance.database;
    return await db.insert('filmes', filme);
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    final db = await instance.database;
    return await db.query('filmes');
  }

  Future<int> update(Map<String, dynamic> filme) async {
    final db = await instance.database;
    return await db.update(
      'filmes',
      filme,
      where: 'id = ?',
      whereArgs: [filme['id']],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete('filmes', where: 'id = ?', whereArgs: [id]);
  }
}
