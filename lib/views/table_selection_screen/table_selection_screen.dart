import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:waiter_cart/routing/app_router.dart';
import 'package:waiter_cart/stores/table_store/table_store.dart';
import 'package:waiter_cart/widgets/table_card.dart';

@RoutePage()
class TableSelectionScreen extends StatefulWidget {
  const TableSelectionScreen({super.key});

  @override
  State<TableSelectionScreen> createState() => _TableSelectionScreenState();
}

class _TableSelectionScreenState extends State<TableSelectionScreen> {
  final TableStore tableStore = GetIt.instance<TableStore>();

  @override
  void initState() {
    tableStore.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Select Table",
        ),
      ),
      body: Observer(
        builder: (_) => tableStore.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                  ),
                  itemCount: tableStore.tables.length,
                  itemBuilder: (context, index) {
                    final table = tableStore.tables[index];
                    return GestureDetector(
                      onTap: () {
                        context.router.push(
                          OrderCreationRoute(
                            tableId: tableStore.tables[index].id,
                          ),
                        ).then((value) => tableStore.loadTables());
                      },
                      child: TableCard(
                        prefixColor: table.isAvailable
                            ? const Color(0xffFFF3CA)
                            : Colors.red,
                        prefixIcon: Icon(
                          table.isAvailable
                              ? Icons.receipt
                              : Icons.lunch_dining_outlined,
                          color: table.isAvailable ? Colors.blue : Colors.white,
                        ),
                        label: table.id.toString(),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
