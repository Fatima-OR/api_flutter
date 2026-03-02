import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';
import 'product_detail_screen.dart';

class ProductsListScreen extends StatefulWidget {
  final ApiService api;

  const ProductsListScreen({Key? key, required this.api}) : super(key: key);

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  late Future<List<Product>> futureProducts;
  List<String> categories = [];
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    futureProducts = widget.api.getProducts();
    loadCategories();
  }

  void loadCategories() async {
    final cats = await widget.api.getCategories();
    setState(() {
      categories = cats;
    });
  }

  void filterCategory(String? category) {
    setState(() {
      selectedCategory = category;

      if (category == null) {
        futureProducts = widget.api.getProducts();
      } else {
        futureProducts =
            widget.api.getProductsByCategory(category);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        centerTitle: true,
      ),
      body: Column(
        children: [

          /// SELECT CATEGORY
          Padding(
            padding: const EdgeInsets.all(12),
            child: DropdownButtonFormField<String>(
              value: selectedCategory,
              hint: const Text("Filter by category"),
              items: [
                const DropdownMenuItem(
                  value: null,
                  child: Text("All Categories"),
                ),
                ...categories.map(
                  (cat) => DropdownMenuItem(
                    value: cat,
                    child: Text(cat),
                  ),
                )
              ],
              onChanged: filterCategory,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),

          /// PRODUCTS LIST
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: futureProducts,
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(
                      child: Text("Erreur de chargement"));
                }

                final products = snapshot.data!;

                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      child: ListTile(
                        leading: Image.network(
                          product.image,
                          width: 50,
                          height: 50,
                          fit: BoxFit.contain,
                        ),
                        title: Text(product.title),
                        subtitle:
                            Text("${product.price} \$"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ProductDetailScreen(
                                      product: product),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}