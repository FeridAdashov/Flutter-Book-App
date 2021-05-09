import 'package:book_project/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ImageDetailPage extends StatelessWidget {
  const ImageDetailPage(
    this.onClose, {
    required this.imagePath,
    required this.name,
    required this.description,
  });

  final void Function({String returnValue}) onClose;
  final String imagePath, name, description;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    int _initialDragTimeStamp = 0;
    double _initialPositionY = 0.0;

    void _startVerticalDrag(details) {
      _initialDragTimeStamp = details.sourceTimeStamp.inMilliseconds;
      _initialPositionY = details.globalPosition.dy;
    }

    void _whileVerticalDrag(details) {
      int _currentDragTimeStamp = details.sourceTimeStamp.inMilliseconds;
      double _currentPositionY = details.globalPosition.dy;

      int _timeDelta = _currentDragTimeStamp - _initialDragTimeStamp;
      double _positionYDelta = _currentPositionY - _initialPositionY;

      if (_timeDelta < 200 && _positionYDelta > 120) Navigator.pop(context);
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onVerticalDragStart: (details) => _startVerticalDrag(details),
      onVerticalDragUpdate: (details) => _whileVerticalDrag(details),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: height * 0.35,
              width: width,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  FittedBox(
                    child: FadeInImage.assetNetwork(
                      image: '$imagePath',
                      placeholder: 'assets/images/loading_gif.gif',
                      fit: BoxFit.cover,
                      width: 50.0,
                      height: 50.0,
                      imageErrorBuilder: (BuildContext context,
                          Object exception, StackTrace? stackTrace) {
                        return SvgPicture.asset('assets/images/book.svg');
                      },
                    ),
                    fit: BoxFit.fill,
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.primaryColor),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      )),
                ],
              ),
            ),
            Container(
              height: height * 0.50,
              padding: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(name,
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text('20.00 AZN',
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                  SizedBox(height: 25),
                  Text(description,
                      style: TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          letterSpacing: 1.5,
                          wordSpacing: 2)),
                ],
              ),
            ),
            Container(
              height: height * 0.15,
              padding: EdgeInsets.all(30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                  ),
                  primary:AppColors.primaryColor,
                ),
                onPressed: () => {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_basket_outlined, color: Colors.white),
                    SizedBox(width: 15),
                    Text('SƏBƏTƏ ƏLAVƏ ET',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
