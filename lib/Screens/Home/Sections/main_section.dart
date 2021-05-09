import 'package:book_project/Screens/Home/Helpers/book_card.dart';
import 'package:book_project/Screens/Home/model/book.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainSection extends StatelessWidget {
  final Function visibleTopSection;

  const MainSection({required this.visibleTopSection});

  @override
  Widget build(BuildContext context) {

    var data = Provider.of<List<Book>>(context);

    ScrollController _controller = ScrollController();
    _controller.addListener((){
      if (_controller.offset >= 50 &&
          !_controller.position.outOfRange) {
        visibleTopSection(false);
      }
      if (_controller.offset <= _controller.position.minScrollExtent &&
          !_controller.position.outOfRange) {
        visibleTopSection(true);
      }
    });

    return GestureDetector(
      child: Center(
        child: GridView.count(
          crossAxisCount: 1,
          children: List.generate(
            data.length,
            (index) {
              return BookCard(
                imagePath: data.elementAt(index).imagePath,
                name: data.elementAt(index).name,
                description: data.elementAt(index).description,
                price: data.elementAt(index).price,
              );
            },
          ),
          controller: _controller,
        ),
      ),
    );
  }
}
