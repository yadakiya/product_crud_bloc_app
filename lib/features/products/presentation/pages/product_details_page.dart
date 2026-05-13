import 'package:flutter/material.dart';
import '../../domain/entities/product_entity.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.network(product.thumbnail, height: 250),

            const SizedBox(height: 20),

            Text(
              product.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(
              "\$${product.price}",
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),

            const SizedBox(height: 20),

            Text(product.description),
          ],
        ),
      ),
    );
  }
}
