import 'package:flutter/material.dart';
import '../models/product.dart';


class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(product.image, height: 200),
              const SizedBox(height: 20),
              Text(product.title,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text("Category: ${product.category}"),
              const SizedBox(height: 10),
              Text("${product.price} \$",
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.green)),
              const SizedBox(height: 20),
              Text(product.description),
            ],
          ),
        ),
      ),
    );
  }
}
