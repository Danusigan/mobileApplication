import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../add_food_screen.dart';
import 'category_details_screen.dart';

class HomeScreen extends StatefulWidget {
  final String userRole;
  final String userName; // <--- ADD THIS

  // Update constructor to require userName
  const HomeScreen({
    super.key,
    this.userRole = 'user',
    required this.userName // <--- ADD THIS
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> categories = [
    {'name': 'Pizza', 'img': 'assets/pizza.jpg'},
    {'name': 'Burger', 'img': 'assets/burger.jpg'},
    {'name': 'Drinks', 'img': 'assets/coke.jpg'},
    {'name': 'Chicken', 'img': 'assets/pizza.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.black),
        title: Column(
          children: [
            // SHOW USER NAME HERE
            Text("Hi, ${widget.userName}!", style: GoogleFonts.poppins(fontSize: 14, color: Colors.black)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.location_on, color: Color(0xFF321587), size: 14),
                Text("Vavuniya, SL", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey)),
              ],
            )
          ],
        ),
        actions: [
          if (widget.userRole == 'admin')
            IconButton(
              icon: const Icon(Icons.admin_panel_settings, color: Colors.deepPurple),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AddFoodScreen()));
              },
            ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(15)),
                child: const TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none, prefixIcon: Icon(Icons.search, color: Colors.grey), hintText: "Search food...",
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Categories
              Text("Categories", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              SizedBox(
                height: 120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 15),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => CategoryDetailsScreen(categoryName: categories[index]['name']!)));
                      },
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade200),
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 60, width: 60, child: Image.asset(categories[index]['img']!, fit: BoxFit.contain)),
                            const SizedBox(height: 10),
                            Text(categories[index]['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Banner
              Container(
                width: double.infinity, height: 150,
                decoration: BoxDecoration(color: const Color(0xFF321587), borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Get 30% OFF", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                          Text("On your first order", style: TextStyle(color: Colors.white70)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}