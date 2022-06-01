import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopatyebelo/models/cartitem.dart';
import 'package:shopatyebelo/provider/cart_provider.dart';
import 'package:shopatyebelo/styles.dart';
import 'package:shopatyebelo/widgets/cart/buttons.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({Key? key, required this.item}) : super(key: key);
  final CartItem item;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 10,
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 8,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            padding: const EdgeInsets.all(10),
                            height: 100,
                            width: 100,
                            child: item.product.image),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 80,
                        width: 1,
                        color: Colors.green,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.product.name, style: TextS.semiBold),
                            Text(item.product.details, softWrap: true),
                            Text('₹ ${item.product.cost}',
                                style: TextS.semiBold),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IncrementQuantity(item: item),
                      Text("X  ${item.quantity}", style: TextS.semiBold),
                      DecrementButton(item: item)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false)
                    .removeItem(item, context);
              },
              icon: const Icon(
                Icons.remove_circle,
                color: Colors.red,
              ))
        ],
      ),
    ]);
  }
}
