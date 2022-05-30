import 'package:flutter/material.dart';
import 'package:shopatyebelo/models/product.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({Key? key, required this.product}) : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          product.image,
          Text(
            product.name,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          Text(
            '\$${product.cost}',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
