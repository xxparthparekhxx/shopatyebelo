import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopatyebelo/models/cartitem.dart';
import 'package:shopatyebelo/provider/cart_provider.dart';

class DecrementButton extends StatelessWidget {
  const DecrementButton({
    Key? key,
    required this.item,
  }) : super(key: key);

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        color: Colors.red,
        onPressed: () => Provider.of<CartProvider>(context, listen: false)
            .decrementQuantity(item.product, context),
        icon: const Icon(Icons.remove));
  }
}

class IncrementQuantity extends StatelessWidget {
  const IncrementQuantity({
    Key? key,
    required this.item,
  }) : super(key: key);

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        color: Colors.green,
        splashColor: Colors.green,
        tooltip:
            item.product.availability > 0 ? "Add more Product" : "Out of Stock",
        onPressed: item.product.availability > 0
            ? () {
                Provider.of<CartProvider>(context, listen: false)
                    .incrementQuantity(item.product, context);
              }
            : null,
        icon: const Icon(Icons.add));
  }
}
