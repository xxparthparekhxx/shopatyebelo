import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopatyebelo/provider/cart_provider.dart';
import 'package:shopatyebelo/screens/cart_page.dart';
import 'package:shopatyebelo/screens/products_page.dart';

class ScreenController extends StatefulWidget {
  const ScreenController({Key? key}) : super(key: key);

  @override
  State<ScreenController> createState() => _ScreenControllerState();
}

class _ScreenControllerState extends State<ScreenController> {
  int _selectedIndex = 0;

  late final List<Widget> screens;
  changeScreen(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    screens = [
      const ProductsPage(),
      CartPage(
        changePage: changeScreen,
      )
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        // Bottom Navigation
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
            tooltip: "Browse Products",
          ),
          BottomNavigationBarItem(
            icon: Stack(children: [
              const Icon(Icons.shopping_cart_outlined, size: 30),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 3.7),
                child: Provider.of<CartProvider>(context).items.isNotEmpty
                    ? Container(
                        height: 10,
                        width: 10,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      )
                    : null,
              ),
            ]),
            activeIcon: const Icon(Icons.shopping_cart, size: 30),
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
