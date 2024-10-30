import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:waiter_cart/views/table_selection_screen/table_selection_screen.dart';
import 'package:waiter_cart/views/order_creation_screen/order_creation_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      initial: true,
      page: TableSelectionRoute.page,
    ),
    AutoRoute(
      page: OrderCreationRoute.page,
    ),
  ];
}