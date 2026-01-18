import 'package:flutter/material.dart';
import '../wrapper.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Login Page", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey)),
              const SizedBox(height: 40),
              const Center(child: Text("Order Eats", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Expanded(child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF321587)),
                          onPressed: (){}, child: const Text("Login", style: TextStyle(color: Colors.white)))),
                      Expanded(child: TextButton(onPressed: (){ Navigator.pop(context); }, child: const Text("Signup")))
                    ]),
                    const SizedBox(height: 20),
                    const Text("User Name :"),
                    const SizedBox(height: 8),
                    TextField(decoration: InputDecoration(filled: true, fillColor: Colors.grey[300], border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none))),
                    const SizedBox(height: 15),
                    const Text("Password :"),
                    const SizedBox(height: 8),
                    TextField(obscureText: true, decoration: InputDecoration(filled: true, fillColor: Colors.grey[300], border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none))),
                    const SizedBox(height: 30),
                    Center(
                      child: SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF321587)),
                          onPressed: () {
                            // Navigate to Home via Wrapper
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const MainWrapper()), (route) => false);
                          },
                          child: const Text("Login", style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}