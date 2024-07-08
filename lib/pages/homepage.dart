import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'cart_page.dart';
import 'product_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    ProductPage(),
    CartPage(),
  ];

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        color: Colors.grey.shade300,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
          child: GNav(
            mainAxisAlignment: MainAxisAlignment.center,
            backgroundColor: Colors.grey.shade300,
            gap: 8,
            activeColor: Colors.black,
            color: Colors.grey[400],
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: Colors.grey.shade100,
            tabBorderRadius: 16,
            tabs: const [
              GButton(
                icon: Icons.watch,
                text: 'Watches',
              ),
              GButton(
                icon: Icons.shopping_cart,
                text: 'Cart',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: navigateBottomBar,
          ),
        ),
      ),
    );
  }
}
