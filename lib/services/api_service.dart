import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  static const String baseUrl = "https://fakestoreapi.com";

  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception("Erreur chargement produits");
    }
  }

  Future<List<String>> getCategories() async {
    final response =
        await http.get(Uri.parse('$baseUrl/products/categories'));

    if (response.statusCode == 200) {
      return List<String>.from(jsonDecode(response.body));
    } else {
      throw Exception("Erreur chargement catégories");
    }
  }

  Future<List<Product>> getProductsByCategory(String category) async {
    final response = await http
        .get(Uri.parse('$baseUrl/products/category/$category'));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception("Erreur catégorie");
    }
  }
  Future<Product> createProduct(Product product) async {
  final response = await http.post(
    Uri.parse('$baseUrl/products'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "title": product.title,
      "price": product.price,
      "description": product.description,
      "image": product.image,
      "category": product.category,
    }),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    return Product.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Erreur création produit");
  }
}
}