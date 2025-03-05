import 'package:get/get.dart';
import 'package:ecommerce/model/product.dart';
import '../services/api_services.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var products = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var productList = await ApiService.fetchProducts();

      print(" Fetched Products Count: ${productList.length}");

      if (productList.isNotEmpty) {
        products.assignAll(productList);
        print(" Products assigned successfully!");
      } else {
        print(" No products found.");
      }
    } catch (e) {
      print(" Error fetching products: $e");
    } finally {
      isLoading(false);
    }
  }
}
