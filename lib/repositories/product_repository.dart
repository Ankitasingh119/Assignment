import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductRepository {
  final http.Client httpClient;

  ProductRepository({required this.httpClient});

  Future<List<Product>> fetchProducts({int offset = 0, int limit = 20}) async {
    final response = await httpClient.get(
      Uri.parse('https://dummyjson.com/products?limit=$limit&skip=$offset'),
    );
    if (response.statusCode != 200) {
      throw Exception('Error fetching products');
    }
    final data = jsonDecode(response.body);
    final items =
        (data['products'] as List)
            .map((json) => Product.fromJson(json))
            .toList();
    return items;
  }
}
