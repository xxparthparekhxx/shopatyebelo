import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopatyebelo/models/cartitem.dart';
import 'package:shopatyebelo/models/product.dart';
import 'package:shopatyebelo/provider/product_provider.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> items = [];

  void loadCart() async {
    // Load data From Shared Preferences
    // // and set it to the items list
    // String key = 'cart';
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? cart = prefs.getString(key);

    // if (cart != null) {
    //   items = [];
    //   List<dynamic> cartItems = jsonDecode(cart);
    //   List<Future<CartItem>> futures = [];
    //   for (var item in cartItems) {
    //     futures.add(CartItem.fromJson(item));
    //   }
    //   for (var ele in futures) {
    //     items.add(await ele);
    //   }
    // } else {
    //   await prefs.setString(key, [].toString());
    // }
    // notifyListeners();
  }

  updatePrefs() async {
    String key = 'cart';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonEncode(items.map((e) => e.toJson()).toList()));
  }

  CartProvider() {
    loadCart();
  }

  addItem(Product p, BuildContext context) {
    if (items.map((e) => e.product.id).toList().contains(p.id)) {
      items
          .firstWhere(
            (element) => element.product == p,
          )
          .quantity++;
    } else {
      items.add(CartItem(p, 1));
    }

    updatePrefs();
    Provider.of<ProductProvider>(context, listen: false)
        .setProductQuantity(p, p.availability - 1);
    notifyListeners();
  }

  bool incrementQuantity(Product product, BuildContext context) {
    if (items
            .firstWhere((element) => element.product == product)
            .product
            .availability >
        0) {
      items.firstWhere((element) => element.product == product).quantity++;
      Provider.of<ProductProvider>(context, listen: false)
          .setProductQuantity(product, product.availability - 1);

      updatePrefs();
      notifyListeners();
      return true;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Out of Stock'),
        backgroundColor: Colors.red,
      ),
    );

    return false;
  }

  decrementQuantity(Product pro, BuildContext context) {
    if (items.firstWhere((element) => element.product == pro).quantity > 1) {
      items.firstWhere((element) => element.product == pro).quantity--;
    } else {
      items.remove(items.firstWhere((element) => element.product == pro));
    }

    updatePrefs();
    notifyListeners();
  }

  int get totalAmount {
    int total = 0;
    for (var item in items) {
      total += item.quantity * item.product.cost;
    }
    return total;
  }

  String get cartItems {
    return jsonEncode(items.map((e) => e.toJson()).toList());
  }

  removeItem(CartItem p, BuildContext context) {
    items.removeWhere((element) => element.product.id == p.product.id);
    Provider.of<ProductProvider>(context, listen: false)
        .setProductQuantity(p.product, p.quantity + p.product.availability);
    updatePrefs();
    notifyListeners();
  }
}
