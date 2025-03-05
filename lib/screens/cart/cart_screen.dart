import 'package:ecommerce/screens/cart/order-summary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce/controllers/cart_controller.dart';
import 'package:ecommerce/model/cart_item.dart';

class CartScreen extends StatelessWidget {
  final CartController cartController = Get.put(CartController());

   CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping Cart"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (cartController.cartItems.isEmpty) {
                return const Center(
                  child: Text(
                    "Your cart is empty!",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  CartItem cartItem = cartController.cartItems[index];

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Image.network(
                        cartItem.image,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 50),
                      ),
                      title: Text(cartItem.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('NPR ${cartItem.price.toStringAsFixed(2)}'),
                      trailing: _buildQuantityControl(cartItem),
                    ),
                  );
                },
              );
            }),
          ),

      
          Obx(() {
            double totalAmount = cartController.totalAmount;

            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Order Summary",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total Items:", style: TextStyle(fontSize: 16)),
                      Text("${cartController.totalCartItems}", style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total Price:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text("NPR ${totalAmount.toStringAsFixed(2)}",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildProceedToPayButton(context, totalAmount),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildQuantityControl(CartItem cartItem) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.remove_circle, color: Colors.redAccent),
          onPressed: () {
            if (cartItem.quantity > 1) {
              cartItem.quantity--;
              cartController.cartItems.refresh();
            } else {
              cartController.cartItems.remove(cartItem);
            }
            cartController.saveCartToStorage();
          },
        ),
        Text(
          cartItem.quantity.toString(),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: const Icon(Icons.add_circle, color: Colors.green),
          onPressed: () {
            cartItem.quantity++;
            cartController.cartItems.refresh();
            cartController.saveCartToStorage(); 
          },
        ),
      ],
    );
  }

  Widget _buildProceedToPayButton(BuildContext context, double totalAmount) {
    return GestureDetector(
      onTap: () {
        Get.to(() => OrderSummaryScreen());
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFff7f00), Color(0xFFff9f00)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            "Proceed to Pay (NPR ${totalAmount.toStringAsFixed(2)})",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
