import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../main_wrapper.dart'; // Import the new wrapper
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // NEW: Dropdown Value
  String _selectedRole = 'User';

  Future<void> login() async {
    try {
      // 1. Authenticate
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // 2. Fetch User Data
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        String dbRole = data['role'] ?? 'user';
        String name = data['name'] ?? 'User';

        // 3. CHECK DROPDOWN MATCH
        // We convert both to lowercase to compare (e.g. "User" vs "user")
        if (_selectedRole.toLowerCase() != dbRole) {
          throw FirebaseAuthException(
              code: 'role-mismatch',
              message: "You are registered as a $dbRole, but tried to login as $_selectedRole."
          );
        }

        if (mounted) {
          // 4. Go to MainWrapper with details
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainWrapper(
                userRole: dbRole,
                userName: name,
                userId: userCredential.user!.uid,
              ),
            ),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? "Login Failed")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Login", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),

            // --- NEW DROPDOWN ---
            DropdownButtonFormField<String>(
              value: _selectedRole,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: "Login As",
                prefixIcon: const Icon(Icons.verified_user),
              ),
              items: ['User', 'Admin'].map((role) {
                return DropdownMenuItem(value: role, child: Text(role));
              }).toList(),
              onChanged: (val) => setState(() => _selectedRole = val!),
            ),
            // --------------------

            const SizedBox(height: 15),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email", prefixIcon: Icon(Icons.email), border: OutlineInputBorder()),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password", prefixIcon: Icon(Icons.lock), border: OutlineInputBorder()),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: login,
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF321587)),
                child: const Text("LOGIN", style: TextStyle(color: Colors.white)),
              ),
            ),
            TextButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUpScreen())),
                child: const Text("Create User Account")
            )
          ],
        ),
      ),
    );
  }
}