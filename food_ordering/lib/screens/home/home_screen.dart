import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../add_food_screen.dart';
import 'category_details_screen.dart';

class HomeScreen extends StatefulWidget {
  final String userRole;
  final String userName;

  const HomeScreen({super.key, this.userRole = 'user', required this.userName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Exact categories from your image
  final List<Map<String, String>> categories = [
    {'name': 'Pizza', 'img': 'assets/pizza2.jpeg'},
    {'name': 'Indian', 'img': 'assets/indian.jpeg'}, // Use appropriate assets
    {'name': 'Burger', 'img': 'assets/burger2.jpeg'},
    {'name': 'Kottu', 'img': 'assets/koththu.jpeg'},
    {'name': 'Soup', 'img': 'assets/soup.jpeg'},
    {'name': 'Juice', 'img': 'assets/juice.jpeg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // Hide default back button, use custom menu icon if needed
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // children: [
          //   //Text("Home page", style: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 14)),
          // ],
        ),
        actions: [
          if (widget.userRole == 'admin')
            IconButton(
              icon: const Icon(Icons.add_circle, color: Color(0xFF321587), size: 30),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddFoodScreen())),
            ),
          const SizedBox(width: 15),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            // 1. GREY BANNER "Hi Name"
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[300], // Light grey background like image
                borderRadius: BorderRadius.circular(0), // Sharp edges as per image
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hi ${widget.userName},", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500)),
                  Text("Good morning!", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 2. "Menu" Title
            Text("Menu", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),

            // 3. GRID VIEW (2 Columns)
            Expanded(
              child: GridView.builder(
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two items per row
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.8, // Taller items
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (_) => CategoryDetailsScreen(categoryName: categories[index]['name']!)
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(categories[index]['img']!, fit: BoxFit.cover),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(categories[index]['name']!, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}