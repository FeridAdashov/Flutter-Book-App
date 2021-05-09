import 'package:animations/animations.dart';
import 'package:book_project/Constants/colors.dart';
import 'package:flutter/material.dart';

import '../ExtraPages/image_detail_page.dart';
import 'image_open_container.dart';

class BookCard extends StatefulWidget {
  final String imagePath, name, description;
  final double price;

  BookCard(
      {required this.imagePath, required this.name, required this.description, required this.price});

  @override
  _BookCardState createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 0.5;
    final double width = MediaQuery.of(context).size.width;

    return Container(
      height: height,
      padding: const EdgeInsets.all(12.0),
      child: Material(
        elevation: 3,
        clipBehavior: Clip.hardEdge,
        type: MaterialType.card,color: AppColors.secondColor,
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            OpenContainer<String>(
              openBuilder: (_, closeContainer) => ImageDetailPage(
                closeContainer,
                imagePath: widget.imagePath,
                name: widget.name,
                description: widget.description,
              ),
              onClosed: (res) => null,
              tappable: false,
              closedBuilder: (_, openContainer) => ImageOpenContainer(
                openContainer: openContainer,
                imagePath: widget.imagePath,
                height: height * 0.8,
                width: width,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 10),
              child: Row(
                children: [
                  Text('${widget.name}',
                      style: TextStyle(color: AppColors.primaryColor, fontSize: 18)),
                  Spacer(),
                  Text('${widget.price} AZN',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
