import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(title: const Text("My Current Orders")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('userId', isEqualTo: userId) // Only Filter (No OrderBy here to avoid Index error)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No orders found."));
          }

          // 1. GET THE DATA
          var orders = snapshot.data!.docs.toList();

          // 2. SORT LOCALLY (Fixes the "Disappearing" bug)
          // We sort by 'date' string in descending order (Newest first)
          orders.sort((a, b) {
            String dateA = a['date'];
            String dateB = b['date'];
            return dateB.compareTo(dateA);
          });

          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              final items = order['items'] as List;

              return Card(
                margin: const EdgeInsets.only(bottom: 15),
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header: Order ID and Status
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "Order #${order.id.substring(0, 6).toUpperCase()}",
                              style: GoogleFonts.poppins(fontWeight: FontWeight.bold)
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade100,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                                order['status'],
                                style: TextStyle(color: Colors.orange.shade800, fontSize: 12, fontWeight: FontWeight.bold)
                            ),
                          ),
                        ],
                      ),
                      const Divider(),

                      // List of Items in this order
                      ...items.map((item) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${item['quantity']} x ${item['name']}", style: const TextStyle(fontSize: 14)),
                            Text("LKR ${item['price']}", style: const TextStyle(fontSize: 14, color: Colors.grey)),
                          ],
                        ),
                      )),

                      const Divider(),

                      // Total Amount
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                            "Total: LKR ${order['amount']}",
                            style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 16)
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}