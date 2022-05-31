import 'package:flutter/material.dart';
import 'package:shopatyebelo/models/product.dart';

class ProductDetails extends StatelessWidget {
  final Product product;
  const ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        children: const [],
      ),
    );
  }
}
