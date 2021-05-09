import 'package:animations/animations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../ExtraPages/image_detail_page.dart';

List<Widget> getImageSliders(List<String> imageList, List<String> textList) {
  return imageList
      .map(
        (item) => Container(
          margin: EdgeInsets.only(top: 5),
          child: OpenContainer<String>(
            openBuilder: (_, closeContainer) => ImageDetailPage(
              closeContainer,
              imagePath: item,
              imageName: textList.elementAt(imageList.indexOf(item)),
            ),
            onClosed: (res) => null,
            tappable: false,
            closedBuilder: (_, openContainer) => OpenImageDetail(
              openContainer: openContainer,
              imagePath: item,
              imageName: textList.elementAt(imageList.indexOf(item)),
            ),
            closedShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
        ),
      )
      .toList();
}

class TopSection extends StatelessWidget {
  final bool selected;

  const TopSection({required this.selected});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 0.25;
    final double width = MediaQuery.of(context).size.width;

    final List<String> imageList = [
      'assets/images/meals/1.jpg',
      'assets/images/meals/2.jpg',
      'assets/images/meals/3.jpg',
      'assets/images/meals/4.jpg',
    ];

    final List<String> textList = [
      'Birinci',
      'Ikinci',
      'Ucuncu',
      'Dorduncu',
    ];

    return AnimatedContainer(
        height: selected ? height : 0.0,
        width: width,
        alignment: selected ? Alignment.center : AlignmentDirectional.topCenter,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        child: CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.scale,
            height: height,
          ),
          items: getImageSliders(imageList, textList),
        ));
  }
}

class OpenImageDetail extends StatelessWidget {
  const OpenImageDetail({
    required this.openContainer,
    required this.imagePath,
    required this.imageName,
  });

  final VoidCallback openContainer;
  final String imagePath, imageName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: openContainer,
      child: Container(
        child: ClipRRect(
            child: Stack(
          children: <Widget>[
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xBCE37695), Color(0xC4AED5D3)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Text(
                  '$imageName',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
