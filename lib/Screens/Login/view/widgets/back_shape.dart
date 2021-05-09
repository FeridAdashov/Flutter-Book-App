import 'package:book_project/Constants/colors.dart';
import 'package:flutter/material.dart';

class CustomShapeClass extends CustomPainter {
  final Size size;
  CustomShapeClass(this.size);

  @override
  void paint(Canvas canvas, Size mSize) {
    var paint = Paint();
    paint.color = AppColors.primaryColor;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height / 2.2);
    path.quadraticBezierTo(
        size.width / 2.5, size.height / 1.8, size.width, size.height / 2.2);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}