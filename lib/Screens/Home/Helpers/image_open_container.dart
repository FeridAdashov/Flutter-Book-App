import 'package:flutter/material.dart';

class ImageOpenContainer extends StatelessWidget {
  const ImageOpenContainer({
    required this.openContainer,
    required this.imagePath,
    required this.height,
    required this.width,
  });

  final VoidCallback openContainer;
  final String imagePath;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: openContainer,
      child: Container(
        height: height,
        width: width,
        child: FittedBox(
          child: Image.network('$imagePath'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
