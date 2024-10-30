import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:waiter_cart/database/app_database.dart';
import 'package:waiter_cart/database/repositories/order_repository.dart';
import 'package:waiter_cart/models/menu_item/menu_item_model.dart';
import 'package:waiter_cart/models/order/order_model.dart';
import 'package:waiter_cart/models/order_item/order_item_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Database? db;
  OrderRepository? orderRepository;
  AppDatabase appDatabase;

  setUp(() async {
    db = await openDatabase(
      inMemoryDatabasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('PRAGMA foreign_keys = ON');
        await db.execute('''CREATE TABLE orders (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, tableId INTEGER)''');
        await db.execute('''CREATE TABLE order_items (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, orderId INTEGER, menuItemId INTEGER, quantity INTEGER, FOREIGN KEY (orderId) REFERENCES orders(id) ON DELETE CASCADE)''');
        await db.execute('''CREATE TABLE menu_items (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, price REAL)''');
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
      },
    );

    appDatabase = AppDatabase();
    appDatabase.testDatabase = db!;
    orderRepository = OrderRepository(appDatabase);
  });

  tearDown(() async {
    await db?.close();
  });

  group('OrderRepository Tests', () {
    test('Upsert order - inserts a new order', () async {
      final order = OrderModel(id: null, tableId: 1);
      final menuItem = MenuItemModel(id: 0, name: 'product #0', price: 250);
      final orderItems = [OrderItemModel(id: null, orderId: order.id ?? 0, menuItem: menuItem, quantity: 3)];

      final orderId = await orderRepository!.upsertOrder(order, orderItems);
      expect(orderId, isNotNull);

      final result = await db!.query('orders', where: 'id = ?', whereArgs: [orderId]);
      expect(result, isNotEmpty);
    });

    test('Upsert order - updates existing order', () async {
      final initialOrder = OrderModel(id: 0, tableId: 1,);
      final menuItem = MenuItemModel(id: 0, name: 'product #0', price: 250);
      final orderItems = [OrderItemModel(id: null, orderId: initialOrder.id ?? 0, menuItem: menuItem, quantity: 3)];

      await orderRepository!.upsertOrder(initialOrder, orderItems);

      final updatedOrderItem = orderItems.first.copyWith(quantity: 4);
      orderItems.first = updatedOrderItem;
      final orderId = await orderRepository!.upsertOrder(initialOrder, orderItems);

      expect(orderId, 0);

      final result = await db!.query('order_items', where: 'id = ?', whereArgs: [orderId]);
      expect(result.first['quantity'], 4);
    });
  });
}
