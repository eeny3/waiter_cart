import 'package:waiter_cart/models/order/order_model.dart';
import 'package:waiter_cart/models/order_item/order_item_model.dart';

class OrderWithItemsModel {
  final OrderModel order;

  final List<OrderItemModel> items;

  OrderWithItemsModel({
    required this.order,
    required this.items,
  });
}
