import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopatyebelo/provider/cart_provider.dart';
import 'package:shopatyebelo/screens/json_display.dart';
import 'package:shopatyebelo/widgets/cart_item.dart';
import 'package:shopatyebelo/widgets/green_button.dart';
import 'package:shopatyebelo/widgets/product_total_count.dart';

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
            if (cp.items.isEmpty)
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
            if (cp.items.isEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  child: InkWell(
                    onTap: () {
                      print(changePage);
                      if (changePage != null) changePage!(0);
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green),
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text("<< Explore Products",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ),
              ),
            ...cp.items.map(
              (e) => CartItemWidget(item: e),
            ),
            const SizedBox(height: 20),
            if (cp.items.isNotEmpty) const Divider(),
            if (cp.items.isNotEmpty)
              ...cp.items.map((e) => ProductsTotalCount(e: e)),
            if (cp.items.isNotEmpty)
              ListTile(
                title: const Text(
                  "Total",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                // find the total for all items in cart
                trailing: Text(
                  cp.totalAmount.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            if (cp.items.isNotEmpty)
              GreenButton(
                  child: const Text("Checkout",
                      style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (c) => JsonDisplayPage(cp: cp)));
                  })
          ],
        ),
      ),
    );
  }
}
