import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("basket", style: TextStyle(fontSize: 18, color: Colors.grey)),
              const SizedBox(height: 40),
              const Center(child: Text("Your Orders!", style: TextStyle(fontSize: 20))),
              const SizedBox(height: 20),
              Expanded(
                child: cart.items.isEmpty
                    ? const Center(child: Text("Bucket is empty"))
                    : ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    return ListTile(
                      title: Text("${index + 1}. ${item.name}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => cart.removeFromCart(item),
                      ),
                    );
                  },
                ),
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF321587), padding: const EdgeInsets.symmetric(horizontal: 50)),
                  onPressed: () {
                    // Confirm Action
                  },
                  child: const Text("Confirm", style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "We are currently not providing delivery options. So come and pickup it on our outlet!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}