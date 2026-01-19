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
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (ctx, i) => ListTile(
                title: Text(cartItems[i].name),
                subtitle: Text("Qty: ${cartItems[i].quantity} x LKR ${cartItems[i].price}"),
                trailing: Text("LKR ${cartItems[i].price * cartItems[i].quantity}"),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (cart.totalAmount <= 0) return;

                  final user = FirebaseAuth.instance.currentUser;

                  // 1. SAVE ORDER
                  await FirebaseFirestore.instance.collection('orders').add({
                    'userId': user?.uid,
                    'amount': cart.totalAmount,
                    'items': cartItems.map((item) => {
                      'id': item.id,
                      'name': item.name,
                      'quantity': item.quantity,
                    }).toList(),
                    'date': DateTime.now().toIso8601String(),
                    'status': 'Pending'
                  });

                  // 2. DECREASE STOCK (Crucial Step)
                  for (var item in cartItems) {
                    // Find the food in DB and decrease count
                    await FirebaseFirestore.instance.collection('foods').doc(item.id).update({
                      'count': FieldValue.increment(-item.quantity)
                    });
                  }

                  cart.clearCart();

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Order Confirmed!")));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF321587),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text("CONFIRM ORDER (LKR ${cart.totalAmount})", style: const TextStyle(color: Colors.white)),
              ),
            ),
          )
        ],
      ),
    );
  }
}