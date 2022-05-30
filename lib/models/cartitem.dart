import 'package:shopatyebelo/models/product.dart';

class CartItem {
  final Product product;
  int quantity;
  CartItem(this.product, this.quantity);
  toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
    };
  }

  static Future<CartItem> fromJson(Map<String, dynamic> json) async {
    return CartItem(
      await Product.fromJson(json['product']),
      json['quantity'] as int,
    );
  }
}
