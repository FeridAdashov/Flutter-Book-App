import 'package:another_flushbar/flushbar.dart';
import 'package:book_project/Constants/colors.dart';
import 'package:flutter/material.dart';

void showFloatingFlushbar(BuildContext context, String title, String message) {
  Flushbar(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
    borderRadius: BorderRadius.circular(15),
    backgroundGradient: LinearGradient(
      colors: [AppColors.primaryColor, AppColors.secondColor],
      stops: [0.6, 1],
    ),
    boxShadows: [
      BoxShadow(
        color: Colors.black45,
        offset: Offset(3, 3),
        blurRadius: 3,
      ),
    ],
    duration: Duration(seconds: 5),
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    title: title,
    message: message,
    icon: Icon(
      Icons.error,
      color: Colors.white,
    ),
  )..show(context);
}

void navigateToPage(BuildContext context, Widget page) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
}

void replacePage(BuildContext context, Widget page) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => page));
}