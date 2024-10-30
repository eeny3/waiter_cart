import 'package:waiter_cart/models/menu_item/menu_item_model.dart';

class OrderItemModel {
  final int? id;

  final int orderId;

  final MenuItemModel menuItem;

  final int quantity;

  OrderItemModel({
    required this.id,
    required this.orderId,
    required this.menuItem,
    required this.quantity,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'orderId': orderId,
    'menuItemId': menuItem.id,
    'quantity': quantity,
  };

  OrderItemModel copyWith({
    int? id,
    int? orderId,
    MenuItemModel? menuItem,
    int? quantity,
  }) {
    return OrderItemModel(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      menuItem: menuItem ?? this.menuItem,
      quantity: quantity ?? this.quantity,
    );
  }
}