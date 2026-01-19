import 'package:flutter/material.dart';
import 'home/home_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';

class MainWrapper extends StatefulWidget {
  final String userRole; // 'admin' or 'user'
  final String userName;
  final String userId;

  const MainWrapper({
    super.key,
    required this.userRole,
    required this.userName,
    required this.userId,
  });

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;
  late final List<Widget> _userPages;
  late final List<Widget> _adminPages;

  @override
  void initState() {
    super.initState();

    // 1. Setup Pages for USERS (Home, Cart, Profile)
    _userPages = [
      HomeScreen(
        userName: widget.userName, // Passing the name here fixes your error!
        userRole: 'user',
      ),
      const CartScreen(),
      ProfileScreen(
        userData: {
          'name': widget.userName,
          'uid': widget.userId,
          'role': 'user'
        },
      ),
    ];

    // 2. Setup Pages for ADMINS (Home, Profile - No Cart)
    _adminPages = [
      HomeScreen(
        userName: "Admin",
        userRole: 'admin',
      ),
      ProfileScreen(
        userData: {
          'name': "Admin",
          'uid': widget.userId,
          'role': 'admin'
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isUser = widget.userRole == 'user';
    final currentPages = isUser ? _userPages : _adminPages;

    return Scaffold(
      body: currentPages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        selectedItemColor: const Color(0xFF321587),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed, // Keeps buttons stable
        items: isUser
            ? const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), activeIcon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Profile'),
        ]
            : const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), activeIcon: Icon(Icons.dashboard), label: 'Admin'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}