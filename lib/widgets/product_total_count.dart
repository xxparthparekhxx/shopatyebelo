import 'package:flutter/material.dart';
import 'package:shopatyebelo/models/cartitem.dart';

class ProductsTotalCount extends StatelessWidget {
  const ProductsTotalCount({
    Key? key,
    required this.e,
  }) : super(key: key);
  final CartItem e;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        "${e.quantity} X ",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      title: Text(e.product.name),
      trailing: Text(
        (e.product.cost * e.quantity).toString(),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
