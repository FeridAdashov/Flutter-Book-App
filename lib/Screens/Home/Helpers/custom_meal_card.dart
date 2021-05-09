import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import '../ExtraPages/image_detail_page.dart';
import 'image_open_container.dart';

class CustomCard extends StatefulWidget {
  final String imagePath, imageName;

  CustomCard({required this.imagePath, required this.imageName});

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 0.2;
    final double width = MediaQuery.of(context).size.width;

    return Container(
      height: height,
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 3,
        clipBehavior: Clip.antiAlias,
        type: MaterialType.card,
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            OpenContainer<String>(
              openBuilder: (_, closeContainer) => ImageDetailPage(
                closeContainer,
                imagePath: widget.imagePath,
                imageName: widget.imageName,
              ),
              onClosed: (res) => null,
              tappable: false,
              closedBuilder: (_, openContainer) => ImageOpenContainer(
                openContainer: openContainer,
                imagePath: widget.imagePath,
                height: height * 0.7,
                width: width,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Text('${widget.imageName}',
                        style: TextStyle(color: Colors.blueGrey.shade800)),
                    Spacer(),
                    Row(
                      children: [
                        Icon(Icons.access_time_sharp, color: Color(0xFF65AE00)),
                        SizedBox(width: 5),
                        Text('20 min',
                            style: TextStyle(color: Color(0xFF65AE00))),
                        Spacer(),
                        Text('20.00 AZN',
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
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