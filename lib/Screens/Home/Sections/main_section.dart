import 'package:another_flushbar/flushbar.dart';
import 'package:book_project/Constants/colors.dart';
import 'package:book_project/Screens/Home/Helpers/book_card.dart';
import 'package:book_project/Screens/Home/model/book.dart';
import 'package:book_project/Services/DatabaseService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainSection extends StatelessWidget {
  final Function visibleTopSection;

  const MainSection({required this.visibleTopSection});

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<List<Book>>(context);

    ScrollController _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.offset >= 50 && !_controller.position.outOfRange) {
        visibleTopSection(false);
      }
      if (_controller.offset <= _controller.position.minScrollExtent &&
          !_controller.position.outOfRange) {
        visibleTopSection(true);
      }
    });

    return GestureDetector(
      child: Center(
        child: ListView.builder(
          controller: _controller,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(data.elementAt(index).name),
              confirmDismiss: (direction) {
                if (direction == DismissDirection.endToStart) {
                  print('aaaaaaaaaa');
                }
                if (direction == DismissDirection.startToEnd) {
                  DatabaseService();
                  showDeleteConfirmFlushbar(
                      context, data.elementAt(index).name);
                }
                return Future.value(false);
              },
              child: BookCard(
                imagePath: data.elementAt(index).imagePath,
                name: data.elementAt(index).name,
                description: data.elementAt(index).description,
                price: data.elementAt(index).price,
              ),
            );
          },
        ),
      ),
    );
  }
}

void showDeleteConfirmFlushbar(BuildContext context, String name) {
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
    duration: Duration(seconds: 4),
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    title: 'Silmək istəyirsiniz?',
    message: '______________________',
    mainButton: TextButton.icon(
      label: Text('Sil', style: TextStyle(color: Colors.red, fontSize: 18)),
      onPressed: () => DatabaseService().deleteBook(name),
      icon: Icon(
        Icons.delete_forever,
        color: Colors.red,
      ),
    ),
    icon: Icon(
      Icons.delete_forever,
      color: Colors.white,
    ),
  )..show(context);
}
