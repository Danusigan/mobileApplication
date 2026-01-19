import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final cartItems = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(title: const Text("My Cart")),
      body: cartItems.isEmpty
          ? const Center(child: Text("Your cart is empty!"))
          : Column(
        children: [
          // LIST OF ITEMS
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (ctx, i) => ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.purple.shade100,
                  child: Text("x${cartItems[i].quantity}"),
                ),
                title: Text(cartItems[i].name),
                subtitle: Text("LKR ${cartItems[i].price * cartItems[i].quantity}"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    cart.removeItem(cartItems[i].id);
                  },
                ),
              ),
            ),
          ),

          // TOTAL & ORDER BUTTON
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -5))],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text("LKR ${cart.totalAmount}", style: const TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (cart.totalAmount <= 0) return;

                      final user = FirebaseAuth.instance.currentUser;

                      // SAVE ORDER TO FIREBASE
                      await FirebaseFirestore.instance.collection('orders').add({
                        'userId': user?.uid,
                        'userEmail': user?.email,
                        'amount': cart.totalAmount,
                        'items': cartItems.map((item) => {
                          'id': item.id,
                          'name': item.name,
                          'quantity': item.quantity,
                          'price': item.price,
                        }).toList(),
                        'status': 'Pending', // Order status
                        'date': DateTime.now().toIso8601String(),
                      });

                      cart.clearCart();

                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Order Placed Successfully!")),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF321587),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text("CONFIRM ORDER", style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}