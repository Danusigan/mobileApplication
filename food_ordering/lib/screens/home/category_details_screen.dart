import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/food_item.dart';
import '../../providers/cart_provider.dart';

class CategoryDetailsScreen extends StatelessWidget {
  final String categoryName;

  const CategoryDetailsScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    // Filter foods by category
    final categoryFoods = allFoods.where((item) => item.category == categoryName).toList();

    return Scaffold(
      appBar: AppBar(title: Text(categoryName), backgroundColor: Colors.white, elevation: 0, foregroundColor: Colors.black),
      body: Column(
        children: [
          // Banner Image
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.orange[100], // Placeholder color
            child: const Icon(Icons.fastfood, size: 80, color: Colors.brown),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: categoryFoods.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final food = categoryFoods[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(food.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                        Text("LKR ${food.price}0", style: const TextStyle(fontSize: 14, color: Colors.grey)),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline, size: 30),
                      onPressed: () {
                        // Add to Bucket Logic
                        Provider.of<CartProvider>(context, listen: false).addToCart(food);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${food.name} added to bucket!")));
                      },
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}