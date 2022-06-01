import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shopatyebelo/provider/cart_provider.dart';
import 'package:shopatyebelo/provider/product_provider.dart';
import 'package:shopatyebelo/screens/screencontroller.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.green,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarContrastEnforced: true));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        child: MaterialApp(
          theme: ThemeData(primarySwatch: Colors.green),
          title: 'Shop App',
          debugShowCheckedModeBanner: false,
          home: const ScreenController(),
        ));
  }
}
