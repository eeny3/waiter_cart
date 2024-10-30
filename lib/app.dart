import 'package:flutter/material.dart';
import 'package:waiter_cart/routing/app_router.dart';

class App extends StatelessWidget {
  final _router = AppRouter();

  App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router.config(),
    );
  }
}
