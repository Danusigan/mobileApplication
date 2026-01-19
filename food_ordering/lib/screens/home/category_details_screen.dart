import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider
import '../../providers/cart_provider.dart'; // Import your CartProvider

class CategoryDetailsScreen extends StatelessWidget {
  final String categoryName;

  const CategoryDetailsScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    // This is just a dummy list for now. In a real app, you fetch this from Firebase.
    final List<Map<String, dynamic>> foods = [
      {'id': '1', 'name': 'Chicken Pizza', 'price': 1500, 'img': 'assets/pizza.jpg'},
      {'id': '2', 'name': 'Veggie Pizza', 'price': 1200, 'img': 'assets/pizza.jpg'},
      {'id': '3', 'name': 'Cheese Burger', 'price': 900, 'img': 'assets/burger.jpg'},
    ];

    // Filter list to match category (simple logic)
    final displayFoods = foods.where((food) => food['name'].toString().contains(categoryName)).toList();

    return Scaffold(
      appBar: AppBar(title: Text("$categoryName Menu")),
      body: ListView.builder(
        itemCount: displayFoods.length,
        itemBuilder: (context, index) {
          final food = displayFoods[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: Image.asset(food['img'], width: 50, height: 50, fit: BoxFit.cover),
              title: Text(food['name']),
              subtitle: Text("LKR ${food['price']}"),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF321587)),
                onPressed: () {
                  // --- FIX IS HERE: Call addItem using Provider ---
                  Provider.of<CartProvider>(context, listen: false).addItem(
                      food['id'],
                      food['name'],
                      food['price']
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${food['name']} added to cart!"))
                  );
                },
                child: const Text("Add", style: TextStyle(color: Colors.white)),
              ),
            ),
          );
        },
      ),
    );
  }
}