import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopatyebelo/models/cartitem.dart';
import 'package:shopatyebelo/models/product.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> items = [];

  void loadCart() async {
    // Load data From Shared Preferences
    // and set it to the items list
    String key = 'cart';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cart = prefs.getString(key);

    if (cart != null) {
      items = [];
      List<dynamic> cartItems = jsonDecode(cart);
      List<Future<CartItem>> futures = [];
      for (var item in cartItems) {
        futures.add(CartItem.fromJson(item));
      }
      for (var ele in futures) {
        items.add(await ele);
      }
    } else {
      await prefs.setString(key, [].toString());
    }
    notifyListeners();
  }

  updatePrefs() async {
    String key = 'cart';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonEncode(items.map((e) => e.toJson()).toList()));
  }

  CartProvider() {
    loadCart();
  }

  addItem(Product p) {
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
    notifyListeners();
  }

  incrementQuantity(Product product) {
    items.firstWhere((element) => element.product == product).quantity++;
    updatePrefs();

    notifyListeners();
  }

  decrementQuantity(Product pro) {
    if (items.firstWhere((element) => element.product == pro).quantity > 1) {
      items.firstWhere((element) => element.product == pro).quantity--;
    } else {
      items.remove(items.firstWhere((element) => element.product == pro));
    }
    updatePrefs();
    notifyListeners();
  }

  String get cartItems {
    return jsonEncode(items.map((e) => e.toJson()).toList());
  }

  removeItem(Product p) {
    items.removeWhere((element) => element.product == p);
    updatePrefs();
    notifyListeners();
  }
}
