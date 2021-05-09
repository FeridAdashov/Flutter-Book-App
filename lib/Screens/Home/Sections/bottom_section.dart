import 'package:book_project/Constants/colors.dart';
import 'package:book_project/Constants/widgets/BottomNavBar/nav_bar.dart';
import 'package:flutter/material.dart';

ClipRRect buildBottomSection(Color firstColor, Color secondColor, int _selectedBottomMenuIndex, Function tapNavBar) {
  return ClipRRect(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(40.0),
      topRight: Radius.circular(40.0),
    ),
    child: CustomNavigationBar(
      backgroundColor: firstColor,
      // initialIndex: 1,
      items: <Widget>[
        Column(
          children: [
            Icon(Icons.logout, size: 30, color: secondColor),
            _selectedBottomMenuIndex != 0
                ? Text('Çıxış',
                style: TextStyle(color: secondColor))
                : SizedBox(height: 0)
          ],
        ),
        Column(
          children: [
            Icon(Icons.search, size: 30, color: secondColor),
            _selectedBottomMenuIndex != 1
                ? Text('Axtar',
                style: TextStyle(color: secondColor))
                : Container(
              height: 0,
              width: 0,
            )
          ],
        ),
        Column(
          children: [
            Icon(Icons.shopping_basket_outlined,
                size: 30, color: secondColor),
            _selectedBottomMenuIndex != 2
                ? Text('Səbət',
                style: TextStyle(color: secondColor))
                : Container(
              height: 0,
              width: 0,
            )
          ],
        ),
      ],
      onTap: (index) => tapNavBar(index), buttonBackgroundColor: AppColors.primaryColor,
    ),
  );
}
