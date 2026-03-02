import 'package:flutter/material.dart';
import 'services/api_service.dart';
import 'screens/products_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fake Store App',
      home: ProductsListScreen(api: ApiService()),
    );
  }
}