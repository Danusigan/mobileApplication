import 'package:flutter/material.dart';
import 'welcome_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_cart, color: Colors.brown),
                    SizedBox(width: 10),
                    Text("Order Eats", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // User Info Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.account_circle, size: 60, color: Colors.black87),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Sanjilraj A.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text("User ID : 005", style: TextStyle(color: Colors.black)),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Menu Items
              const Divider(color: Colors.black54),
              const ListTile(title: Text("Promotions")),
              const Divider(color: Colors.black54),
              const ListTile(title: Text("Buckets")),
              const Divider(color: Colors.black54),
              const ListTile(title: Text("Current Orders")),
              const Divider(color: Colors.black54),

              const Spacer(),

              // Logout Button
              Center(
                child: SizedBox(
                  width: 200,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD32F2F), // Red color
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))
                    ),
                    onPressed: () {
                      // Go back to Welcome/Login
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const WelcomeScreen()), (route) => false);
                    },
                    child: const Text("Logout", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}