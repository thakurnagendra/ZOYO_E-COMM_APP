import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ecommerce/model/cart_item.dart';

class CartController extends GetxController {
  final box = GetStorage();
  var cartItems = <CartItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCartFromStorage();
  }

  int get totalCartItems =>
      cartItems.fold(0, (sum, item) => sum + item.quantity);
  double get totalAmount =>
      cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));

  void addToCart(CartItem newItem) {
    var existingProduct =
        cartItems.firstWhereOrNull((item) => item.id == newItem.id);
    if (existingProduct != null) {
      existingProduct.quantity++;
    } else {
      cartItems.add(newItem);
    }
    saveCartToStorage();
    cartItems.refresh();
  }

  void removeFromCart(CartItem product) {
    var cartItem = cartItems.firstWhereOrNull((item) => item.id == product.id);
    if (cartItem != null) {
      if (cartItem.quantity > 1) {
        cartItem.quantity--;
      } else {
        cartItems.remove(cartItem);
      }
      saveCartToStorage();
      cartItems.refresh();
    }
  }

  void clearCart() {
    cartItems.clear();
    saveCartToStorage();
    cartItems.refresh();
  }

  void saveCartToStorage() {
    List<Map<String, dynamic>> cartJsonList =
        cartItems.map((item) => item.toJson()).toList();
    box.write('cart', cartJsonList);
  }

  void loadCartFromStorage() {
    List<dynamic>? cartJsonList = box.read('cart');
    if (cartJsonList != null) {
      cartItems.assignAll(
          cartJsonList.map((item) => CartItem.fromJson(item)).toList());
    }
  }
}
