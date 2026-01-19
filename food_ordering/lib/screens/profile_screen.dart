import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'auth/login_screen.dart';
import 'orders_screen.dart'; // We will create this small file next

class ProfileScreen extends StatelessWidget {
  final Map<String, dynamic> userData;

  const ProfileScreen({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    final bool isUser = userData['role'] == 'user';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (context.mounted) {
                // Clear stack and go back to login
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                      (Route<dynamic> route) => false,
                );
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // PROFILE IMAGE (Placeholder)
            const CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFF321587),
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 20),

            // USER INFO CARD
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  _buildInfoRow(Icons.person, "Name", userData['name']),
                  const Divider(),
                  _buildInfoRow(Icons.email, "Email", FirebaseAuth.instance.currentUser?.email ?? "No Email"),
                  const Divider(),
                  _buildInfoRow(Icons.badge, "User ID", userData['uid']),
                  const Divider(),
                  _buildInfoRow(Icons.security, "Role", userData['role'].toString().toUpperCase()),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // "CURRENT ORDERS" BUTTON (Only for Users)
            if (isUser)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const OrdersScreen()));
                  },
                  icon: const Icon(Icons.receipt_long),
                  label: const Text("View My Orders"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF321587),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(15),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                Text(value, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}