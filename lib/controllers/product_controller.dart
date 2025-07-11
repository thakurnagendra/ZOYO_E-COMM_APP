import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ecommerce/model/product.dart';
import '../services/api_services.dart';

class ProductController extends GetxController {
  final box = GetStorage();
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
      if (productList.isNotEmpty) {
        products.assignAll(productList);
      } else {
        products.clear();
      }
    } catch (e) {
      products.clear();
    } finally {
      isLoading(false);
    }
  }
}
