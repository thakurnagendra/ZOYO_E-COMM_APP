import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ecommerce/model/product.dart';

class ApiService {
  static Future<List<Product>> fetchProducts() async {
    try {
      
      var response = await http.get(Uri.parse('https://fakestoreapi.com/products'));

      print(" API Response Code: ${response.statusCode}");
      print(" API Response Body (First 300 chars): ${response.body.substring(0, 300)}");

      if (response.statusCode == 200) {
        try {
          List<dynamic> jsonData = json.decode(response.body);
          print("JSON Parsed Successfully. Product Count: ${jsonData.length}");
          return jsonData.map((item) => Product.fromJson(item)).toList();
        } catch (e) {
          print(" JSON Parsing Error: $e");
          return [];
        }
      } else {
        print(" API Error: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print(" API Exception: $e");
      return [];
    }
  }
}
