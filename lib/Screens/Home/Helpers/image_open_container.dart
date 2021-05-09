import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
          child: FadeInImage.assetNetwork(
            image: '$imagePath',
            placeholder: 'assets/images/loading_gif.gif',
            fit: BoxFit.cover,
            width: 50.0,
            height: 50.0,
            imageErrorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return SvgPicture.asset('assets/images/book.svg');
            },
          ),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
