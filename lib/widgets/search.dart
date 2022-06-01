import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopatyebelo/provider/product_provider.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController controller = TextEditingController();
  bool isInited = false;

  init() {
    controller.addListener(() {
      setState(() {});
      Provider.of<ProductProvider>(context, listen: false).Search =
          controller.text;
    });
    isInited = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!isInited) {
      init();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            prefixIcon: const Icon(Icons.search),
            suffixIcon: controller.text != ""
                ? IconButton(
                    onPressed: () {
                      controller.clear();
                    },
                    icon: const Icon(Icons.cancel))
                : null,
            label: const Text("Search for products")),
      ),
    );
  }
}
