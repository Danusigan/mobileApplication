import 'package:flutter/material.dart';
import '../../models/food_item.dart';
import 'category_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, String>> categories = const [
    {'name': 'Pizza', 'img': 'assets/pizza_cat.png'},
    {'name': 'Indian', 'img': 'assets/indian_cat.png'},
    {'name': 'Burger', 'img': 'assets/burger_cat.png'},
    {'name': 'Kottu', 'img': 'assets/kottu_cat.png'},
    {'name': 'Soup', 'img': 'assets/soup_cat.png'},
    {'name': 'Juice', 'img': 'assets/juice_cat.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Home page", style: TextStyle(fontSize: 18, color: Colors.grey)),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                color: Colors.grey[300],
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hi danu,", style: TextStyle(fontSize: 16)),
                    Text("Good morning!", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text("Menu", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigate to specific category page
                        Navigator.push(context, MaterialPageRoute(
                            builder: (_) => CategoryDetailsScreen(categoryName: categories[index]['name']!)
                        ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Placeholder image
                            const Icon(Icons.fastfood, size: 50, color: Colors.orange),
                            const SizedBox(height: 10),
                            Text(categories[index]['name']!),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}