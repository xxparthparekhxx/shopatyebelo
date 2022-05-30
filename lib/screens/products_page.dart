import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopatyebelo/provider/product_provider.dart';
import 'package:shopatyebelo/screens/widgets/category_tile.dart';
import 'package:shopatyebelo/screens/widgets/product_tile.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pp = Provider.of<ProductProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: pp.categories.length,
                  itemBuilder: (ctx, idx) => CategoryItem(
                        category: pp.categories[idx],
                      ))),
          Expanded(
            flex: 9,
            child: GridView.builder(
              itemCount: pp.productList.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300),
              itemBuilder: (ctx, idx) =>
                  ProductTile(product: pp.productList[idx]),
            ),
          ),
        ],
      ),
    );
  }
}
