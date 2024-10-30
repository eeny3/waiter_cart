import 'package:injectable/injectable.dart';
import 'package:waiter_cart/database/app_database.dart';
import 'package:waiter_cart/models/menu_item/menu_item_model.dart';
import 'package:waiter_cart/models/order/order_model.dart';
import 'package:waiter_cart/models/order_item/order_item_model.dart';
import 'package:waiter_cart/models/order_with_items/order_with_items_model.dart';
import 'package:waiter_cart/utils/app_logger.dart';

@injectable
class OrderRepository {
  final AppDatabase _appDatabase;

  OrderRepository(this._appDatabase);

  Future<int> upsertOrder(OrderModel order, List<OrderItemModel> items) async {
    try {
      final db = await _appDatabase.database;
      return await db.transaction((txn) async {
        int orderId;

        if (order.id != null) {
          int affectedRows = await txn.update(
            'orders',
            order.toMap(),
            where: 'id = ?',
            whereArgs: [order.id],
          );

          if (affectedRows > 0) {
            orderId = order.id!;
          } else {
            orderId = await txn.insert('orders', order.toMap());
          }
        } else {
          orderId = await txn.insert('orders', order.toMap());
        }

        for (var item in items) {
          final existingItem = await txn.query(
            'order_items',
            where: 'orderId = ? AND menuItemId = ?',
            whereArgs: [orderId, item.menuItem.id],
          );

          if (existingItem.isNotEmpty) {
            await txn.update(
              'order_items',
              item.toMap(),
              where: 'id = ?',
              whereArgs: [existingItem.first['id']],
            );
          } else {
            await txn.insert('order_items',
                item.copyWith(id: null, orderId: orderId).toMap());
          }
        }

        final itemIds = items.map((item) => item.menuItem.id).toList();
        await txn.delete(
          'order_items',
          where:
              'orderId = ? AND menuItemId NOT IN (${List.filled(itemIds.length, '?').join(', ')})',
          whereArgs: [orderId, ...itemIds],
        );

        return orderId;
      });
    } catch (e, stackTrace) {
      AppLogger.error("Failed to get upsert order", e, stackTrace);
      rethrow;
    }
  }

  Future<OrderWithItemsModel?> getOrderWithItems(int orderId) async {
    try {
      final db = await _appDatabase.database;

      final orderMap = await db.query(
        'orders',
        where: 'id = ?',
        whereArgs: [orderId],
      );

      if (orderMap.isEmpty) return null;

      // Query associated items and join with MenuItems
      final itemsMap = await db.rawQuery(
        '''
    SELECT order_items.*, menu_items.name, menu_items.price 
    FROM order_items 
    INNER JOIN menu_items ON order_items.menuItemId = menu_items.id
    WHERE order_items.orderId = ?
    ''',
        [orderId],
      );

      // Map results to Dart objects
      final order = OrderModel.fromMap(orderMap.first);
      final items = itemsMap.map((itemMap) {
        final menuItem = MenuItemModel(
          id: itemMap['menuItemId'] as int,
          name: itemMap['name'] as String,
          price: itemMap['price'] as double,
        );
        return OrderItemModel(
          id: itemMap['id'] as int,
          orderId: order.id ?? 0,
          menuItem: menuItem,
          quantity: itemMap['quantity'] as int,
        );
      }).toList();

      return OrderWithItemsModel(
        order: order,
        items: items,
      );
    } catch (e, stackTrace) {
      AppLogger.error(
          "Failed to get order with order items by ID $orderId", e, stackTrace);
      rethrow;
    }
  }

  Future<int?> getOrderIdByTableId(int tableId) async {
    try {
      final db = await _appDatabase.database;
      // Query the Orders table for the latest order with the given tableId
      final result = await db.query(
        'orders',
        columns: ['id'],
        where: 'tableId = ?',
        whereArgs: [tableId],
        limit: 1,
      );

      // If an order is found, return its id; otherwise, return null
      if (result.isNotEmpty) {
        return result.first['id'] as int;
      } else {
        return null;
      }
    } catch (e, stackTrace) {
      AppLogger.error(
          "Failed to get order by table ID $tableId", e, stackTrace);
      rethrow;
    }
  }

  Future<void> deleteOrder(int orderId) async {
    try {
      final db = await _appDatabase.database;
      await db.transaction((txn) async {
        await txn.delete(
          'orders',
          where: 'id = ?',
          whereArgs: [orderId],
        );
      });
      AppLogger.info("Order $orderId deleted successfully.");
    } catch (e, stackTrace) {
      AppLogger.error("Failed to delete order with ID $orderId", e, stackTrace);
      rethrow;
    }
  }
}
