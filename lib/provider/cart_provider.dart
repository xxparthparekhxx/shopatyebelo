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
      for (var item in cartItems) {
        items.add(await CartItem.fromJson(item));
      }
    } else {
      await prefs.setString(key, [].toString());
    }
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
      items.firstWhere((element) => element.product == p).quantity++;
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
