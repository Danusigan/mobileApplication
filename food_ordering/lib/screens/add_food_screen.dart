import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddFoodScreen extends StatefulWidget {
  // NEW: Optional arguments for Edit Mode
  final Map<String, dynamic>? foodData;
  final String? foodId;

  const AddFoodScreen({super.key, this.foodData, this.foodId});

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _countController = TextEditingController();
  String _selectedCategory = 'Pizza';
  final List<String> _categories = ['Pizza', 'Indian', 'Burger', 'Kottu', 'Soup', 'Juice'];

  @override
  void initState() {
    super.initState();
    // NEW: If editing, pre-fill the text fields
    if (widget.foodData != null) {
      _nameController.text = widget.foodData!['name'];
      _priceController.text = widget.foodData!['price'].toString();
      _countController.text = widget.foodData!['count'].toString();
      _selectedCategory = widget.foodData!['category'];
    }
  }

  Future<void> saveFood() async {
    if (_nameController.text.isEmpty || _priceController.text.isEmpty || _countController.text.isEmpty) return;

    final data = {
      'name': _nameController.text,
      'price': int.parse(_priceController.text),
      'count': int.parse(_countController.text),
      'category': _selectedCategory,
      'imagePath': 'assets/pizza.jpg', // Default image (you can make this editable later)
      'createdAt': DateTime.now(),
    };

    if (widget.foodId != null) {
      // --- UPDATE EXISTING FOOD ---
      await FirebaseFirestore.instance.collection('foods').doc(widget.foodId).update(data);
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Item Updated Successfully!")));
    } else {
      // --- ADD NEW FOOD ---
      await FirebaseFirestore.instance.collection('foods').add(data);
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Item Added Successfully!")));
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.foodId != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? "Edit Item" : "Add New Item")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
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
                  onPressed: saveFood,
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF321587)),
                  child: Text(isEditing ? "UPDATE ITEM" : "ADD TO MENU", style: const TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}