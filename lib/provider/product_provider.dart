import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shopatyebelo/models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> products = [];
  Set<String> categoriesFound = {};

  String defaultCategory = "All";
  String currentCategory = "All";

  getProducts() async {
    //setting default category
    categoriesFound.add(defaultCategory);

    //loading data from json
    String rawData = await rootBundle.loadString(
      "lib/assets/products.json",
      cache: true,
    );
    List<dynamic> jsonData = jsonDecode(rawData);

    // activate the image download for all the products images
    List<Future<Product>> futures = [];
    for (var productData in jsonData) {
      futures.add(Product.fromJson(productData));
    }

    // wait for all the images to be downloaded
    // faster than awaiting for each one in a single loop
    // as the requests are done in parallel

    for (var element in futures) {
      Product product = await element;
      products.add(product); // add created product to the list
      categoriesFound
          .add(product.category); // add found product categories to the list
    }
    notifyListeners();
  }

  set filter(String e) {
    //set filter to the current category
    currentCategory = e;
    notifyListeners();
  }

  List<Product> get productList {
    if (currentCategory == defaultCategory) {
      //default category
      return products;
    } else {
      //filter by category found in json
      return products
          .where((element) => element.category == currentCategory)
          .toList();
    }
  }

  List<String> get categories {
    //return unique categories
    return categoriesFound.toList();
  }

  ProductProvider() {
    () async {
      await getProducts();
    }();
  }
}
