import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddFoodScreen extends StatefulWidget {
  const AddFoodScreen({super.key});

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _countController = TextEditingController(); // NEW: Quantity Controller

  String _selectedCategory = 'Pizza';
  final List<String> _categories = ['Pizza', 'Indian', 'Burger', 'Kottu', 'Soup', 'Juice'];

  Future<void> addFood() async {
    if (_nameController.text.isEmpty || _priceController.text.isEmpty || _countController.text.isEmpty) return;

    await FirebaseFirestore.instance.collection('foods').add({
      'name': _nameController.text,
      'price': int.parse(_priceController.text),
      'count': int.parse(_countController.text), // NEW: Save Count
      'category': _selectedCategory,
      'imagePath': 'assets/pizza.jpg', // Default image (you can improve this later)
      'createdAt': DateTime.now(),
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Food Added Successfully!")));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Item")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Food Name", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Price (LKR)", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 15),
            // NEW: Quantity Input
            TextField(
              controller: _countController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Quantity Available", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField(
              value: _selectedCategory,
              items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (val) => setState(() => _selectedCategory = val!),
              decoration: const InputDecoration(labelText: "Category", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: addFood,
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF321587)),
                child: const Text("ADD TO MENU", style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}