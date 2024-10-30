// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OrderStore on _OrderStore, Store {
  late final _$orderAtom = Atom(name: '_OrderStore.order', context: context);

  @override
  OrderWithItemsModel? get order {
    _$orderAtom.reportRead();
    return super.order;
  }

  @override
  set order(OrderWithItemsModel? value) {
    _$orderAtom.reportWrite(value, super.order, () {
      super.order = value;
    });
  }

  late final _$orderItemsAtom =
      Atom(name: '_OrderStore.orderItems', context: context);

  @override
  ObservableList<OrderItemModel> get orderItems {
    _$orderItemsAtom.reportRead();
    return super.orderItems;
  }

  @override
  set orderItems(ObservableList<OrderItemModel> value) {
    _$orderItemsAtom.reportWrite(value, super.orderItems, () {
      super.orderItems = value;
    });
  }

  late final _$menuItemsAtom =
      Atom(name: '_OrderStore.menuItems', context: context);

  @override
  ObservableList<MenuItemModel> get menuItems {
    _$menuItemsAtom.reportRead();
    return super.menuItems;
  }

  @override
  set menuItems(ObservableList<MenuItemModel> value) {
    _$menuItemsAtom.reportWrite(value, super.menuItems, () {
      super.menuItems = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_OrderStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_OrderStore.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$loadMenuAsyncAction =
      AsyncAction('_OrderStore.loadMenu', context: context);

  @override
  Future<void> loadMenu() {
    return _$loadMenuAsyncAction.run(() => super.loadMenu());
  }

  late final _$loadOrderAsyncAction =
      AsyncAction('_OrderStore.loadOrder', context: context);

  @override
  Future<void> loadOrder() {
    return _$loadOrderAsyncAction.run(() => super.loadOrder());
  }

  late final _$saveOrderAsyncAction =
      AsyncAction('_OrderStore.saveOrder', context: context);

  @override
  Future<void> saveOrder() {
    return _$saveOrderAsyncAction.run(() => super.saveOrder());
  }

  late final _$checkoutTableAsyncAction =
      AsyncAction('_OrderStore.checkoutTable', context: context);

  @override
  Future<void> checkoutTable() {
    return _$checkoutTableAsyncAction.run(() => super.checkoutTable());
  }

  late final _$_OrderStoreActionController =
      ActionController(name: '_OrderStore', context: context);

  @override
  dynamic addItem(MenuItemModel menuItem) {
    final _$actionInfo =
        _$_OrderStoreActionController.startAction(name: '_OrderStore.addItem');
    try {
      return super.addItem(menuItem);
    } finally {
      _$_OrderStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic increaseQuantity(int itemIndex) {
    final _$actionInfo = _$_OrderStoreActionController.startAction(
        name: '_OrderStore.increaseQuantity');
    try {
      return super.increaseQuantity(itemIndex);
    } finally {
      _$_OrderStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic decreaseQuantity(int itemIndex) {
    final _$actionInfo = _$_OrderStoreActionController.startAction(
        name: '_OrderStore.decreaseQuantity');
    try {
      return super.decreaseQuantity(itemIndex);
    } finally {
      _$_OrderStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
order: ${order},
orderItems: ${orderItems},
menuItems: ${menuItems},
isLoading: ${isLoading},
errorMessage: ${errorMessage}
    ''';
  }
}
