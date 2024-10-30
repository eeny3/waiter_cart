import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

@singleton
class AppDatabase {

  Database? _database;

  Future<Database> get database async {
    _database ??= await _initDB('app_database.db');
    return _database!;
  }

  // Setter for testing purposes only
  set testDatabase(Database db) {
    _database = db;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('PRAGMA foreign_keys = ON');
    await db.execute('''
    CREATE TABLE IF NOT EXISTS tables (
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      isAvailable INTEGER NOT NULL
    )
    ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS menu_items (
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      name TEXT,
      price REAL
    )
    ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS orders (
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      tableId INTEGER,
      totalPrice REAL
    )
    ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS order_items (
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      orderId INTEGER,
      menuItemId INTEGER,
      quantity INTEGER,
      FOREIGN KEY (orderId) REFERENCES orders(id) ON DELETE CASCADE,
      FOREIGN KEY (menuItemId) REFERENCES menu_items(id)
    )
    ''');

    for(int i = 0; i < 15; i++) {
      await db.insert(
        'tables',
        {
          'id': i,
          'isAvailable': 1,
        },
      );
    }

    for(int i = 0; i < 25; i++) {
      await db.insert(
        'menu_items',
        {
          'id': i,
          'name': 'product #$i',
          'price': 250
        },
      );
    }
  }

  Future close() async {
    final db = _database;
    if (db != null) {
      await db.close();
    }
  }
}
