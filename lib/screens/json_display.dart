import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopatyebelo/provider/cart_provider.dart';

class JsonDisplayPage extends StatelessWidget {
  const JsonDisplayPage({
    Key? key,
    required this.cp,
  }) : super(key: key);

  final CartProvider cp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Json Data'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(15)),
                padding: const EdgeInsets.all(15),
                child: SelectableText(
                  cp.cartItems,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: cp.cartItems));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Json data copied to clipboard")));
                    },
                    child: const Icon(Icons.copy),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
