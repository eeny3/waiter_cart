import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:waiter_cart/stores/order_store/order_store.dart';

@RoutePage()
class OrderCreationScreen extends StatefulWidget {
  final int tableId;

  const OrderCreationScreen({
    super.key,
    required this.tableId,
  });

  @override
  State<OrderCreationScreen> createState() => _OrderCreationScreenState();
}

class _OrderCreationScreenState extends State<OrderCreationScreen> {
  late final OrderStore orderStore;

  @override
  void initState() {
    orderStore = OrderStore(widget.tableId);
    orderStore.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(
          0xffF8F5F9,
        ),
        title: const Text(
          'Table',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              orderStore.saveOrder();
            },
            icon: const Icon(
              Icons.check,
              color: Colors.blueAccent,
            ),
          ),
          IconButton(
            onPressed: () async {
              await orderStore.checkoutTable();
              if (context.mounted) {
                context.router.back();
              }
            },
            icon: const Icon(
              Icons.payment_outlined,
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Observer(builder: (context) {
          if (orderStore.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (orderStore.errorMessage != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(orderStore.errorMessage!),
                  action: SnackBarAction(
                    label: 'Retry',
                    onPressed: () {
                      orderStore.init();
                    },
                  ),
                ),
              );
              orderStore.errorMessage = null; // Reset after displaying
            });
          }

          return Padding(
            padding: const EdgeInsets.fromLTRB(
              16,
              16,
              16,
              0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: orderStore.orderItems.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  orderStore.orderItems[index].menuItem.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  (orderStore.orderItems[index].menuItem.price *
                                          orderStore.orderItems[index].quantity)
                                      .toInt()
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    orderStore.increaseQuantity(index);
                                  },
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  orderStore.orderItems[index].quantity
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    orderStore.decreaseQuantity(index);
                                  },
                                  child: const Icon(
                                    Icons.remove,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: orderStore.menuItems.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          orderStore.addItem(orderStore.menuItems[index]);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          padding: const EdgeInsets.all(4),
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xffFFFEFF),
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Image.network(
                                        'https://www.coca-cola.com/content/dam/onexp/kz/ru/homepage-images/brands/coca-cola/coca-cola-classic_product_image-desktop.jpg',
                                      ),
                                    ),
                                    Flexible(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            orderStore.menuItems[index].price
                                                .toInt()
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                orderStore.menuItems[index].name,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
