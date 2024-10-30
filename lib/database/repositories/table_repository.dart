import 'package:injectable/injectable.dart';
import 'package:waiter_cart/database/app_database.dart';
import 'package:waiter_cart/models/table/table_model.dart';
import 'package:waiter_cart/utils/app_logger.dart';

@injectable
class TableRepository {
  final AppDatabase _appDatabase;

  TableRepository(this._appDatabase);

  Future<List<TableModel>> getAllTables() async {
    try {
      final db = await _appDatabase.database;
      final tables = await db.query('tables');
      return tables.map((e) => TableModel.fromMap(e)).toList();
    } catch (e, stackTrace) {
      AppLogger.error("Failed to get All Tables", e, stackTrace);
      rethrow;
    }
  }

  Future<void> insertTable(TableModel table) async {
    try {
      final db = await _appDatabase.database;
      await db.insert('tables', table.toMap());
    } catch (e, stackTrace) {
      AppLogger.error("Failed to insert Table", e, stackTrace);
      rethrow;
    }
  }

  Future<void> updateTableAvailability(int id, bool isAvailable) async {
    try {
      final db = await _appDatabase.database;
      await db.update(
        'tables',
        {'isAvailable': isAvailable ? 1 : 0},
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e, stackTrace) {
      AppLogger.error("Failed to update Table Availability", e, stackTrace);
      rethrow;
    }
  }
}
