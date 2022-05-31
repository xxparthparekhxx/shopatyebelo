import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopatyebelo/provider/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cp = Provider.of<CartProvider>(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text(
              'Your Cart',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            if (cp.items.isEmpty) const Text('No items in cart'),
            ...cp.items.map(
              (e) {
                var item = e;
                return Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          height: 100,
                          width: 100,
                          child: item.product.image),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 80,
                        width: 1,
                        color: Colors.black87,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.product.name),
                          Text(item.product.details),
                          Text('₹ ${item.product.cost}'),
                        ],
                      ),
                    )
                  ],
                );
              },
            ).toList(),
            const SizedBox(height: 20),
            if (cp.items.isNotEmpty)
              ...cp.items.map((e) => ListTile(
                    leading: Text("${e.quantity} X "),
                    title: Text(e.product.name),
                    trailing: Text(e.product.cost.toString()),
                  )),
            if (cp.items.isNotEmpty)
              ListTile(
                title: const Text("Total"),
                trailing: Text(cp.items
                    .map((e) => e.product.cost)
                    .reduce((a, b) => a + b)
                    .toString()),
              ),
            if (cp.items.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green),
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text("Checkout",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
