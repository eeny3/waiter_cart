import 'package:injectable/injectable.dart';
import 'package:waiter_cart/database/app_database.dart';
import 'package:waiter_cart/models/menu_item/menu_item_model.dart';
import 'package:waiter_cart/utils/app_logger.dart';

@injectable
class MenuItemRepository {
  final AppDatabase _appDatabase;

  MenuItemRepository(this._appDatabase);

  Future<List<MenuItemModel>> getAllMenuItems() async {
    try {
      final db = await _appDatabase.database;
      final menuItems = await db.query('menu_items');
      return menuItems.map((e) => MenuItemModel.fromMap(e)).toList();
    } catch (e, stackTrace) {
      AppLogger.error("Failed to get menu items", e, stackTrace);
      rethrow;
    }
  }

  Future<void> insertMenuItem(MenuItemModel menuItem) async {
    try {
      final db = await _appDatabase.database;
      await db.insert('menu_items', menuItem.toMap());
    } catch (e, stackTrace) {
      AppLogger.error("Failed to insert menu item", e, stackTrace);
      rethrow;
    }
  }
}
