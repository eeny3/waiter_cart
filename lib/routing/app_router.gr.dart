// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [OrderCreationScreen]
class OrderCreationRoute extends PageRouteInfo<OrderCreationRouteArgs> {
  OrderCreationRoute({
    Key? key,
    required int tableId,
    List<PageRouteInfo>? children,
  }) : super(
          OrderCreationRoute.name,
          args: OrderCreationRouteArgs(
            key: key,
            tableId: tableId,
          ),
          initialChildren: children,
        );

  static const String name = 'OrderCreationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OrderCreationRouteArgs>();
      return OrderCreationScreen(
        key: args.key,
        tableId: args.tableId,
      );
    },
  );
}

class OrderCreationRouteArgs {
  const OrderCreationRouteArgs({
    this.key,
    required this.tableId,
  });

  final Key? key;

  final int tableId;

  @override
  String toString() {
    return 'OrderCreationRouteArgs{key: $key, tableId: $tableId}';
  }
}

/// generated route for
/// [TableSelectionScreen]
class TableSelectionRoute extends PageRouteInfo<void> {
  const TableSelectionRoute({List<PageRouteInfo>? children})
      : super(
          TableSelectionRoute.name,
          initialChildren: children,
        );

  static const String name = 'TableSelectionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TableSelectionScreen();
    },
  );
}
