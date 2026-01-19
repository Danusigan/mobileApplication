import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/cart_provider.dart';
import '../add_food_screen.dart'; // Import this to navigate for editing

class CategoryDetailsScreen extends StatelessWidget {
  final String categoryName;
  final String userRole; // --- NEW: To check if Admin or User

  const CategoryDetailsScreen({super.key, required this.categoryName, required this.userRole});

  String _getCategoryImage() {
    switch (categoryName.toLowerCase()) {
      case 'pizza': return 'assets/pizza.jpg';
      case 'indian': return 'assets/burger.jpg';
      case 'burger': return 'assets/burger.jpg';
      case 'kottu': return 'assets/pizza.jpg';
      case 'soup': return 'assets/coke.jpg';
      case 'juice': return 'assets/coke.jpg';
      default: return 'assets/burger.jpg';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = userRole == 'admin';

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. TOP BIG IMAGE
          Stack(
            children: [
              SizedBox(
                height: 250,
                width: double.infinity,
                child: Image.asset(_getCategoryImage(), fit: BoxFit.cover),
              ),
              Positioned(
                top: 40,
                left: 10,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black, size: 30),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Positioned(
                top: 50,
                left: 60,
                child: Text(
                  categoryName,
                  style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              )
            ],
          ),

          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(categoryName, style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 10),

          // 2. REAL DATA LIST FROM FIREBASE
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('foods')
                  .where('category', isEqualTo: categoryName)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No items available in this category yet."));
                }

                final foods = snapshot.data!.docs;

                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: foods.length,
                  separatorBuilder: (ctx, i) => const Divider(thickness: 1),
                  itemBuilder: (context, index) {
                    final data = foods[index].data() as Map<String, dynamic>;
                    final foodId = foods[index].id;
                    final int stock = data['count'] ?? 0;
                    final bool isAvailable = stock > 0;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Food Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data['name'], style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500)),
                                const SizedBox(height: 5),
                                Text("LKR ${data['price']}.00", style: GoogleFonts.poppins(fontSize: 14, color: Colors.black)),
                                if (!isAvailable)
                                  const Text("Out of Stock", style: TextStyle(color: Colors.red, fontSize: 12)),
                              ],
                            ),
                          ),

                          // --- ADMIN LOGIC ---
                          if (isAdmin)
                            Row(
                              children: [
                                // EDIT BUTTON
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () {
                                    // Navigate to AddFoodScreen but PASS existing data
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (_) => AddFoodScreen(foodData: data, foodId: foodId)
                                    ));
                                  },
                                ),
                                // DELETE BUTTON
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    // Confirm Delete
                                    showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          title: const Text("Delete Item?"),
                                          content: const Text("Are you sure you want to remove this item permanently?"),
                                          actions: [
                                            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
                                            TextButton(
                                                onPressed: () async {
                                                  Navigator.pop(ctx);
                                                  await FirebaseFirestore.instance.collection('foods').doc(foodId).delete();
                                                },
                                                child: const Text("Delete", style: TextStyle(color: Colors.red))
                                            ),
                                          ],
                                        )
                                    );
                                  },
                                ),
                              ],
                            )
                          else
                          // --- USER LOGIC (Buy Button) ---
                            IconButton(
                              onPressed: isAvailable ? () {
                                Provider.of<CartProvider>(context, listen: false).addItem(
                                    foodId,
                                    data['name'],
                                    data['price']
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("${data['name']} added to cart!"), duration: const Duration(seconds: 1))
                                );
                              } : null,
                              icon: Icon(Icons.add_circle_outline, size: 30, color: isAvailable ? Colors.black : Colors.grey),
                            ),
                        ],
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