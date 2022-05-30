import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopatyebelo/provider/cart_provider.dart';
import 'package:shopatyebelo/provider/product_provider.dart';
import 'package:shopatyebelo/screens/products_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ProductProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => CartProvider(),
          )
        ],
        child: const MaterialApp(
          title: 'Shop App',
          home: ProductsPage(),
        ));
  }
}
