import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddFoodScreen extends StatefulWidget {
  const AddFoodScreen({super.key});

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers to capture user text
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  // Default values
  String selectedCategory = 'Pizza';
  String selectedImage = 'assets/pizza.jpg';

  // List of categories matching your Home Screen
  final List<String> categories = ['Pizza', 'Burger', 'Drinks', 'Chicken'];

  Future<void> saveFood() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('foods').add({
          'name': nameController.text,
          'price': double.parse(priceController.text),
          'category': selectedCategory,
          'imagePath': selectedImage,
          // Note: Real apps upload images, but for now we use your asset files
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Food Added Successfully!')),
        );

        // Clear the form
        nameController.clear();
        priceController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Item")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // 1. Name Input
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Food Name'),
                validator: (value) => value!.isEmpty ? 'Enter a name' : null,
              ),

              // 2. Price Input
              TextFormField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price (LKR)'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter a price' : null,
              ),
              const SizedBox(height: 20),

              // 3. Category Dropdown
              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: const InputDecoration(labelText: 'Category'),
                items: categories.map((cat) {
                  return DropdownMenuItem(value: cat, child: Text(cat));
                }).toList(),
                onChanged: (val) => setState(() => selectedCategory = val!),
              ),
              const SizedBox(height: 20),

              // 4. Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: saveFood,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text("SAVE TO DATABASE"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}