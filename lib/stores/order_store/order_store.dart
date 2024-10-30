import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:waiter_cart/database/repositories/menu_item_repository.dart';
import 'package:waiter_cart/database/repositories/order_repository.dart';
import 'package:waiter_cart/database/repositories/table_repository.dart';
import 'package:waiter_cart/models/menu_item/menu_item_model.dart';
import 'package:waiter_cart/models/order/order_model.dart';
import 'package:waiter_cart/models/order_item/order_item_model.dart';
import 'package:waiter_cart/models/order_with_items/order_with_items_model.dart';
import 'package:waiter_cart/utils/app_logger.dart';

part 'order_store.g.dart';

@injectable
// ignore: library_private_types_in_public_api
class OrderStore = _OrderStore with _$OrderStore;

abstract class _OrderStore with Store {
  final OrderRepository _orderRepository = GetIt.instance<OrderRepository>();
  final MenuItemRepository _menuRepository =
      GetIt.instance<MenuItemRepository>();
  final TableRepository _tableRepository = GetIt.instance<TableRepository>();
  final int tableId;

  _OrderStore(
    this.tableId,
  );

  Future<void> init() async {
    await loadOrder();
    await loadMenu();
  }

  @observable
  OrderWithItemsModel? order;

  @observable
  ObservableList<OrderItemModel> orderItems =
      ObservableList<OrderItemModel>.of([]);

  @observable
  ObservableList<MenuItemModel> menuItems = ObservableList<MenuItemModel>();

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  Future<void> loadMenu() async {
    try {
      isLoading = true;
      final menuItemsList = await _menuRepository.getAllMenuItems();
      menuItems = ObservableList.of(menuItemsList);
      isLoading = false;
    } catch (e) {
      errorMessage = "Failed to loadMenu";
      AppLogger.error(errorMessage!, e);
    }
  }

  @action
  Future<void> loadOrder() async {
    try {
      isLoading = true;

      final orderId = await _orderRepository.getOrderIdByTableId(tableId);
      if (orderId == null) {
        order = OrderWithItemsModel(
          order: OrderModel(
            id: null,
            tableId: tableId,
          ),
          items: [],
        );
        isLoading = false;
        return;
      }
      order = await _orderRepository.getOrderWithItems(orderId);

      orderItems = ObservableList.of(order!.items);

      isLoading = false;
    } catch (e) {
      errorMessage = "Failed to loadOrder";
      AppLogger.error(errorMessage!, e);
    }
  }

  @action
  Future<void> saveOrder() async {
    try {
      isLoading = true;
      final newOrder = order!.order;
      final newOrderItems = orderItems;
      await _orderRepository.upsertOrder(newOrder, newOrderItems);
      await _tableRepository.updateTableAvailability(tableId, false);
      isLoading = false;
    } catch (e) {
      errorMessage = "Failed to saveOrder";
      AppLogger.error(errorMessage!, e);
    }

    loadOrder();
  }

  @action
  addItem(MenuItemModel menuItem) {
    final orderWithExistingItemIndex =
        getOrderWithExistingItemIndexOrNull(menuItem);
    if (orderWithExistingItemIndex != null) {
      final newOrderItem = orderItems[orderWithExistingItemIndex].copyWith(
        quantity: orderItems[orderWithExistingItemIndex].quantity + 1,
      );
      orderItems[orderWithExistingItemIndex] = newOrderItem;
    } else {
      final newItem = OrderItemModel(
        id: null,
        orderId: order!.order.id ?? 0,
        menuItem: menuItem,
        quantity: 1,
      );
      orderItems.add(newItem);
    }
  }

  @action
  Future<void> checkoutTable() async {
    try {
      isLoading = true;
      final orderId = await _orderRepository.getOrderIdByTableId(tableId);
      if (orderId == null) {
        isLoading = false;
        return;
      }
      await _orderRepository.deleteOrder(orderId);
      await _tableRepository.updateTableAvailability(tableId, true);
      isLoading = false;
    } catch (e) {
      errorMessage = "Failed to checkoutTable";
      AppLogger.error(errorMessage!, e);
    }
  }

  @action
  increaseQuantity(int itemIndex) {
    final newOrderItem = orderItems[itemIndex]
        .copyWith(quantity: orderItems[itemIndex].quantity + 1);
    orderItems[itemIndex] = newOrderItem;
  }

  @action
  decreaseQuantity(int itemIndex) {
    if (orderItems[itemIndex].quantity - 1 > 0) {
      final newOrderItem = orderItems[itemIndex]
          .copyWith(quantity: orderItems[itemIndex].quantity - 1);
      orderItems[itemIndex] = newOrderItem;
    } else {
      orderItems.removeAt(itemIndex);
    }
  }

  int? getOrderWithExistingItemIndexOrNull(MenuItemModel menuItem) {
    for (int i = 0; i < orderItems.length; i++) {
      if (orderItems[i].menuItem.id == menuItem.id) {
        return i;
      }
    }

    return null;
  }
}
