import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class AddProductScreen extends StatefulWidget {
  final ApiService api;
  final VoidCallback onProductAdded;

  const AddProductScreen({
    Key? key,
    required this.api,
    required this.onProductAdded,
  }) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageController = TextEditingController();
  final categoryController = TextEditingController();

  bool isLoading = false;

  void submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    final newProduct = Product(
      id: 0,
      title: titleController.text,
      price: double.parse(priceController.text),
      description: descriptionController.text,
      image: imageController.text,
      category: categoryController.text,
    );

    try {
      await widget.api.createProduct(newProduct);

      widget.onProductAdded();

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Produit ajouté avec succès")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erreur lors de l'ajout")),
      );
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter Produit"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [

                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: "Titre",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Champ requis" : null,
                ),
                const SizedBox(height: 15),

                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Prix",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Champ requis" : null,
                ),
                const SizedBox(height: 15),

                TextFormField(
                  controller: descriptionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Champ requis" : null,
                ),
                const SizedBox(height: 15),

                TextFormField(
                  controller: imageController,
                  decoration: const InputDecoration(
                    labelText: "URL Image",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Champ requis" : null,
                ),
                const SizedBox(height: 15),

                TextFormField(
                  controller: categoryController,
                  decoration: const InputDecoration(
                    labelText: "Catégorie",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Champ requis" : null,
                ),
                const SizedBox(height: 25),

                isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: submit,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                        ),
                        child: const Text("Ajouter"),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}