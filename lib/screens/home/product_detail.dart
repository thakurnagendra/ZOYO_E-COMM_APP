import 'package:flutter/material.dart';
import '../../model/product.dart';


class ProductDetailScreen extends StatelessWidget {
  final Product product;

 
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Column(
        children: [
          Image.network(product.image),
          Text(product.title),
          Text('Rs. ${product.price}'),
        ],
      ),
    );
  }
}
