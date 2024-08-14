
import 'package:flutter/material.dart';
import 'package:tehjumbofirebase/shared/theme.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar(
      {required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: bgColor,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            buildBottomNavItem(Icons.home, 0),
            buildBottomNavItem(Icons.shopping_bag, 1),
            buildBottomNavItem(Icons.person, 2),
          ],
        ),
      ),
    );
  }

  Widget buildBottomNavItem(IconData icon, int index) {
    return MaterialButton(
      //minWidth: 40,
      onPressed: () => onTap(index),
      child: Icon(icon, color: currentIndex == index ? green : Colors.black),
    );
  }
}
