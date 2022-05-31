import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopatyebelo/models/cartitem.dart';
import 'package:shopatyebelo/models/product.dart';
import 'package:shopatyebelo/provider/cart_provider.dart';
import 'package:shopatyebelo/provider/product_provider.dart';

class ProductDetails extends StatelessWidget {
  final Product product;
  const ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size ss = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(color: Colors.green),
      padding: const EdgeInsets.all(10),
      height: ss.height * 0.7,
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(19.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(10)),
                width: ss.width * 0.5,
                height: ss.height * 0.2,
                child: product.image,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        product.name,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(product.details,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black87))
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '₹ ${product.cost}',
                        style:
                            const TextStyle(fontSize: 24, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Quantity Available ${product.availability}',
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  if (product.availability != 0)
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: Stack(children: [
                        FloatingActionButton(
                            onPressed: () {
                              Provider.of<CartProvider>(context, listen: false)
                                  .addItem(product);
                            },
                            child: const Icon(Icons.add_shopping_cart_sharp)),
                        if (Provider.of<CartProvider>(context)
                                .items
                                .firstWhere(
                                  (element) =>
                                      element.product.name == product.name,
                                  orElse: () => CartItem(
                                      Provider.of<ProductProvider>(context)
                                          .products
                                          .firstWhere((element) =>
                                              element.id == product.id),
                                      0),
                                )
                                .quantity >
                            0)
                          Container(
                            height: 20,
                            width: 20,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.red),
                            child: Center(
                              child: Text(
                                Provider.of<CartProvider>(context)
                                    .items
                                    .firstWhere((element) =>
                                        element.product.id == product.id)
                                    .quantity
                                    .toString(),
                              ),
                            ),
                          ),
                      ]),
                    ),
                  if (product.availability == 0)
                    const Text('Out of Stock',
                        style: TextStyle(color: Colors.red))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
