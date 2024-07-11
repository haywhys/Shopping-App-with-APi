
import 'package:flutter/material.dart';

import 'cart.dart';
import 'gridview.dart';

class CustomBottomNav extends StatefulWidget {
  const CustomBottomNav({super.key});

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {

  int currentIndex=0;

  final pages = [
    const MyDisplays(),
    const Cart(),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items:  const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            backgroundColor: Colors.blue,
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
            // backgroundColor: Colors.blue,
          ),

        ],
        onTap: (index)
        {
          setState(() {
            currentIndex = index;
          });
        },

      ),
    );
  }
}

