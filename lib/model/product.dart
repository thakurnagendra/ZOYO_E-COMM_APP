import 'package:get/get.dart';

class Product {
  final int id;  
  final String title;
  final String image;
  final double price;
  var quantity = 1.obs;
  var isFavorite = false.obs;

  Product({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    int quantity = 1,
    bool isFavorite = false,
  }) {
    this.quantity.value = quantity;
    this.isFavorite.value = isFavorite;
  }

 
  factory Product.fromJson(Map<String, dynamic> json) {
    try {
      return Product(
        id: json['id'], 
        title: json['title'] ?? "Unknown",
        image: json['image'] ?? "",
        price: (json['price'] ?? 0).toDouble(),
      );
    } catch (e) {
      print(" Error parsing product JSON: $e");
      return Product(id: 0, title: "Unknown", image: "", price: 0.0);
    }
  }
}
