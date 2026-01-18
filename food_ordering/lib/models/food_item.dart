class FoodItem {
  final String id;
  final String name;
  final double price;
  final String imagePath; // Use asset paths or network URLs
  final String category;

  FoodItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
    required this.category,
  });
}

// MOCK DATA for all 6 Categories
final List<FoodItem> allFoods = [
  // 1. Pizza Category
  FoodItem(
      id: 'p1',
      name: 'Veggie Masala Pizza',
      price: 1350.0,
      category: 'Pizza',
      imagePath: 'assets/pizza.jpg' // Ensure file is named "pizza.jpg"
  ),
  FoodItem(
      id: 'p2',
      name: 'Chilli Chicken Pizza',
      price: 1450.0,
      category: 'Pizza',
      imagePath: 'assets/pizza2.jpg' // Ensure file is named "pizza2.jpg"
  ),

  // 2. Burger Category
  FoodItem(
      id: 'b1',
      name: 'Veggie Masala Burger',
      price: 1350.0,
      category: 'Burger',
      imagePath: 'assets/burger.jpg' // Ensure file is named "burger.jpg"
  ),
  FoodItem(
      id: 'b2',
      name: 'Double Chicken Burger',
      price: 1650.0,
      category: 'Burger',
      imagePath: 'assets/burger2.jpg' // Ensure file is named "burger2.jpg"
  ),

  // 3. Indian Category
  FoodItem(
      id: 'i1',
      name: 'Chicken Biryani',
      price: 1200.0,
      category: 'Indian',
      imagePath: 'assets/indian.jpg'
  ),

  // 4. Kottu Category
  FoodItem(
      id: 'k1',
      name: 'Cheese Kottu',
      price: 1100.0,
      category: 'Kottu',
      imagePath: 'assets/koththu.jpg' // Matches your specific spelling "koththu"
  ),

  // 5. Soup Category
  FoodItem(
      id: 's1',
      name: 'Mushroom Soup',
      price: 850.0,
      category: 'Soup',
      imagePath: 'assets/soup.jpg'
  ),

  // 6. Juice Category
  FoodItem(
      id: 'j1',
      name: 'Mixed Fruit Juice',
      price: 450.0,
      category: 'Juice',
      imagePath: 'assets/juice.jpg'
  ),
];