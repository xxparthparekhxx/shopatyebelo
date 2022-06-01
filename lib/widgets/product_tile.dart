import 'package:flutter/material.dart';
import 'package:shopatyebelo/models/product.dart';
import 'package:shopatyebelo/widgets/product_details.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({Key? key, required this.product}) : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius = BorderRadius.circular(10);

    return Material(
      borderRadius: borderRadius,
      elevation: 10,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (c) => ProductDetails(product: product));
        },
        child: Container(
          decoration: BoxDecoration(borderRadius: borderRadius),
          width: 250,
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: product.image),
              Stack(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                alignment: Alignment.bottomCenter,
                children: [
                  ClipRRect(
                    borderRadius: borderRadius,
                    child: Row(
                      children: [
                        Expanded(
                          child: Image.asset('lib/assets/grass.png',
                              fit: BoxFit.cover),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '₹ ${product.cost}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
