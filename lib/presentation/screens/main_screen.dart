import 'package:deels_here/core/themes/app_colors.dart';
import 'package:deels_here/presentation/screens/navbar_screens/card_screen.dart';
import 'package:deels_here/presentation/screens/navbar_screens/home_screen.dart';
import 'package:deels_here/presentation/screens/navbar_screens/profile_screen.dart';
import 'package:deels_here/presentation/screens/navbar_screens/upload_file_screen.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    CartScreen(),
    UploadFileScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder:
          (context, constraints) => Scaffold(
            body: _screens[_selectedIndex],
            extendBody: true, // Ensures body extends behind the navigation bar
            bottomNavigationBar: SizedBox(
              width: constraints.maxWidth,
              height: 100,
              child: DotNavigationBar(
                backgroundColor: AppColors.primaryColor.withValues(alpha: .3),
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
                dotIndicatorColor: Colors.blue,
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.white,
                paddingR: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                marginR: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                items: [
                  DotNavigationBarItem(
                    icon: Icon(Icons.home),
                    selectedColor: Colors.blue,
                    unselectedColor: Colors.white,
                  ),
                  DotNavigationBarItem(
                    icon: Icon(Icons.shopping_cart),
                    selectedColor: Colors.blue,
                    unselectedColor: Colors.white,
                  ),
                  DotNavigationBarItem(
                    icon: Icon(Icons.upload),
                    selectedColor: Colors.blue,
                    unselectedColor: Colors.white,
                  ),
                  DotNavigationBarItem(
                    icon: Icon(Icons.person),
                    selectedColor: Colors.blue,
                    unselectedColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
