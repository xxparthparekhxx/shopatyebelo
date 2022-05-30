import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopatyebelo/provider/product_provider.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.category,
  }) : super(key: key);

  final String category;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: Material(
          child: InkWell(
            onTap: () {
              Provider.of<ProductProvider>(context, listen: false).filter =
                  category;
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient:
                      Provider.of<ProductProvider>(context).currentCategory ==
                              category
                          ? const LinearGradient(colors: [
                              Color.fromRGBO(44, 129, 18, 1),
                              Color.fromRGBO(116, 197, 144, 1)
                            ])
                          : null),
              child: Text(
                category,
                style: TextStyle(
                    color:
                        Provider.of<ProductProvider>(context).currentCategory ==
                                category
                            ? Colors.white
                            : Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
