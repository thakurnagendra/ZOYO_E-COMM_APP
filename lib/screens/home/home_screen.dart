import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce/controllers/cart_controller.dart';
import 'package:ecommerce/controllers/product_controller.dart';
import 'package:ecommerce/model/product.dart';
import 'package:ecommerce/screens/cart/cart_screen.dart';
import '../../controllers/auth_controller.dart';
import 'product_detail.dart';
import 'package:ecommerce/model/cart_item.dart';

class HomeScreen extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());
  final CartController cartController = Get.put(CartController());
  final AuthController authController = Get.put(AuthController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Obx(() {
        if (productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (productController.products.isEmpty) {
          return const Center(
            child: Text(
              "No products available",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          );
        }
        return _buildProductGrid();
      }),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.deepOrange,
      leading: IconButton(
        icon: const Icon(Icons.logout, color: Colors.white),
        onPressed: () {
          authController.signOut();
        },
      ),
      automaticallyImplyLeading: false,
      title: const Text(
        "ZOYO",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'Cursive',
        ),
      ),
      centerTitle: true,
      actions: [
        _buildCartIcon(),
      ],
    );
  }

  Widget _buildCartIcon() {
    return Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.shopping_cart, color: Colors.white),
          onPressed: () {
            Get.to(() => CartScreen());
          },
        ),
        Positioned(
          right: 6,
          top: 6,
          child: Obx(() {
            int cartCount = cartController.totalCartItems;
            return cartCount > 0
                ? CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text(
                      cartCount.toString(),
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  )
                : const SizedBox();
          }),
        ),
      ],
    );
  }

  Widget _buildProductGrid() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        itemCount: productController.products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          Product product = productController.products[index];
          return _buildProductCard(product);
        },
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(product: product)),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                product.image,
                width: double.infinity,
                height: 120,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, size: 80),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'NPR ${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 14, color: Colors.green),
                  ),
                  const SizedBox(height: 4),
                  _buildAddToCartButton(product),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddToCartButton(Product product) {
    return ElevatedButton(
      onPressed: () {
        cartController.addToCart(
          CartItem(
            id: product.id,
            name: product.title,
            price: product.price,
            quantity: 1,
            image: product.image,
          ),
        );
        Get.snackbar("Product Added", "${product.title} added to cart",
            snackPosition: SnackPosition.BOTTOM);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      child: const Text('Add to Cart'),
    );
  }
}
