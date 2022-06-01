import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopatyebelo/provider/cart_provider.dart';
import 'package:shopatyebelo/screens/json_display.dart';
import 'package:shopatyebelo/styles.dart';
import 'package:shopatyebelo/widgets/cart/cart_item.dart';
import 'package:shopatyebelo/widgets/green_button.dart';
import 'package:shopatyebelo/widgets/cart/product_total_count.dart';

class CartPage extends StatelessWidget {
  final Function(int)? changePage;
  const CartPage({Key? key, this.changePage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cp = Provider.of<CartProvider>(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Your Cart',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            if (cp.items.isEmpty) ...[
              Center(
                  child: Image.network(
                "https://shvetdhara.com/img/ecart.png",
                isAntiAlias: true,
                color: Colors.green,
                loadingBuilder: (context, child, progress) {
                  return progress == null
                      ? child
                      : const Center(
                          child: CircularProgressIndicator(),
                        );
                },
              )),
              GreenButton(
                  onPressed: () {
                    if (changePage != null) changePage!(0);
                  },
                  child: const Text("<< Explore Products", style: TextS.white))
            ],
            ...cp.items.map(
              (e) => CartItemWidget(item: e),
            ),
            const SizedBox(height: 20),
            if (cp.items.isNotEmpty) ...[
              const Divider(),
              ...cp.items.map((e) => ProductsTotalCount(e: e)),
              ListTile(
                title: const Text("Total", style: TextS.bold),
                // total for all items in cart
                trailing: Text(
                  cp.totalAmount.toString(),
                  style: TextS.bold,
                ),
              ),
              GreenButton(
                  child: const Text("Checkout", style: TextS.white),
                  onPressed: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (c) => JsonDisplayPage(cp: cp)));
                  })
            ]
          ],
        ),
      ),
    );
  }
}
