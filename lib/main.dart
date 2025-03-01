import 'package:flutter/material.dart';
import 'package:myapp/main_screen.dart';

void main() {
  runApp(const BookShopApp());
}

class BookShopApp extends StatelessWidget {
  const BookShopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Shop',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MainScreen(),
    );
  }
}