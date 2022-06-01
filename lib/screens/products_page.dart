import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopatyebelo/provider/product_provider.dart';
import 'package:shopatyebelo/widgets/category_tile.dart';
import 'package:shopatyebelo/widgets/product_tile.dart';
import 'package:shopatyebelo/widgets/search.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pp = Provider.of<ProductProvider>(context);
    if (pp.products.isNotEmpty) {
      return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                const Search(),
                SizedBox(
                    height: 50,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: pp.categories.length,
                        itemBuilder: (ctx, idx) => CategoryItem(
                              category: pp.categories[idx],
                            ))),
                Expanded(
                  flex: 9,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      itemCount: pp.productList.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 250,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16),
                      itemBuilder: (ctx, idx) =>
                          ProductTile(product: pp.productList[idx]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
