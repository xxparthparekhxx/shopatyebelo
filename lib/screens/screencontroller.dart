import 'package:flutter/material.dart';
import 'package:shopatyebelo/screens/cart_page.dart';
import 'package:shopatyebelo/screens/products_page.dart';

class ScreenController extends StatefulWidget {
  const ScreenController({Key? key}) : super(key: key);

  @override
  State<ScreenController> createState() => _ScreenControllerState();
}

class _ScreenControllerState extends State<ScreenController> {
  int _selectedIndex = 0;

  final List<Widget> screens = const [ProductsPage(), CartPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
            tooltip: "Browse Products",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromRGBO(44, 129, 18, 1),
        onTap: (int e) => setState(() {
          _selectedIndex = e;
        }),
      ),
    );
  }
}
