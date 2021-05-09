import 'package:book_project/Constants/colors.dart';
import 'package:book_project/Constants/widgets/BottomNavBar/nav_bar.dart';
import 'package:flutter/material.dart';

ClipRRect buildBottomSection(Color firstColor, Color secondColor,
    int _selectedBottomMenuIndex, Function tapNavBar) {
  return ClipRRect(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30.0),
      topRight: Radius.circular(30.0),
    ),
    child: CustomNavigationBar(
      backgroundColor: firstColor,
      // initialIndex: 1,
      items: <Widget>[
        bottomBarItem('Çıxış', Icons.logout, _selectedBottomMenuIndex == 0),
        bottomBarItem('Axtar', Icons.search, _selectedBottomMenuIndex == 1),
        bottomBarItem('Səbət', Icons.shopping_basket_outlined, _selectedBottomMenuIndex == 2),
        bottomBarItem('Əlavə et', Icons.add, _selectedBottomMenuIndex == 3),
      ],
      onTap: (index) => tapNavBar(index),
      buttonBackgroundColor: AppColors.primaryColor,
    ),
  );
}

Column bottomBarItem(
    String text, IconData iconData, bool isSelected) {
  return Column(
    children: [
      Icon(
        iconData,
        size: 30,
        color: isSelected ? Colors.white : AppColors.primaryColor,
      ),
      isSelected
          ? SizedBox(height: 0)
          : Text(text, style: TextStyle(color: AppColors.primaryColor))
    ],
  );
}
