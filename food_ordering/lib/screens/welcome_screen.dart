import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'auth/signup_screen.dart';
import 'auth/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Logo and Title at the top - Horizontal version
          Padding(
            padding: const EdgeInsets.only(top: 60.0, left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  'assets/logo.jpeg',
                  width: 40,
                  height: 40,
                ),
                const SizedBox(width: 12),
                // Title
                Text(
                  "Order Eats",
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF321587), // Matching button color
                  ),
                ),
              ],
            ),
          ),

          // Add padding before the image using Padding widget
          const Padding(
            padding: EdgeInsets.only(top: 0.0), // Reduced from 60 to 20
          ),

          Expanded(
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(top: 10.0), // Add top padding
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0.0), // Add border radius
                  child: Image.asset(
                    'assets/bur.jpg',
                    width: double.infinity,
                    height: 500,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Text(
                  "Order Your Food Now!",
                  style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  "Order food and get delivery within a few minutes to your door",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 40),

                // SIGN UP BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF321587),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text("Get Started", style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
                const SizedBox(height: 15),

                // LOGIN BUTTON
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                  },
                  child: const Text("Already have an account? Login", style: TextStyle(color: Colors.grey)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
