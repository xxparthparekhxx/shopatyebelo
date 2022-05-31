import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Product {
  final String name;
  final int id;
  final int cost;
  final int availability;
  final String details;
  final String category;
  final Widget image;
  final String imageUrl;

  Product(this.name, this.id, this.cost, this.availability, this.details,
      this.category, this.image, this.imageUrl);

  static Future<Product> fromJson(Map<String, dynamic> json) async {
    var image = await http.get(Uri.parse(json['image']));
    return Product(
      json['p_name'] as String? ?? "",
      json['p_id'] as int,
      json['p_cost'] as int,
      json['p_availability'] as int,
      json['p_details'] as String? ?? "",
      json['p_category'] as String? ?? "All",
      Image.memory(image.bodyBytes),
      json['image'].toString(),
    );
  }

  toJson() {
    return {
      'p_name': name,
      'p_id': id,
      'p_cost': cost,
      'p_availability': availability,
      'p_details': details,
      'p_category': category,
      'image': imageUrl,
    };
  }
}
