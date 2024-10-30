import 'package:flutter/material.dart';
import 'package:waiter_cart/app.dart';
import 'package:waiter_cart/database/app_database.dart';
import 'package:waiter_cart/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeLocator();

  runApp(App());
}