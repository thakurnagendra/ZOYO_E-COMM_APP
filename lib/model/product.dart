class Product {
  final int id;
  final String title;
  final String image;
  final double price;
  int quantity;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    this.quantity = 1,
    this.isFavorite = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    try {
      return Product(
        id: json['id'],
        title: json['title'] ?? "Unknown",
        image: json['image'] ?? "",
        price: (json['price'] ?? 0).toDouble(),
        quantity: json['quantity'] ?? 1,
        isFavorite: json['isFavorite'] ?? false,
      );
    } catch (e) {
      print(" Error parsing product JSON: $e");
      return Product(id: 0, title: "Unknown", image: "", price: 0.0);
    }
  }
}
