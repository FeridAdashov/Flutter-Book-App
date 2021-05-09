import 'package:another_flushbar/flushbar.dart';
import 'package:book_project/Constants/colors.dart';
import 'package:book_project/Screens/Home/model/book.dart';
import 'package:book_project/Services/DatabaseService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => page));
}

Future<void> showAddBookDialog(context) async {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final imagePathController = TextEditingController();
  final priceController = TextEditingController();

  ValueNotifier<bool> _isFavouriteNotifier = ValueNotifier(false);

  showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColors.homeBaseColor,
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              textFieldAlertDialog(nameController, 'Kitab adı',
                  isNumber: false),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 5),
                child: textFieldAlertDialog(
                    descriptionController, 'Haqqında məlumat'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                child: textFieldAlertDialog(
                    imagePathController, 'Şəkil linki (.jpg, .png)'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 10),
                child: textFieldAlertDialog(priceController, 'Qimyət', isNumber: true),
              ),
              ValueListenableBuilder(
                valueListenable: _isFavouriteNotifier,
                builder: (BuildContext context, bool hasError, Widget? child) {
                  return ListTile(
                    title: Text(
                      'Sevimlilərə əlavə et',
                      style: TextStyle(color: AppColors.secondColor),
                    ),
                    trailing: IconButton(
                      onPressed: () => _isFavouriteNotifier.value =
                          !_isFavouriteNotifier.value,
                      icon: Icon(
                        _isFavouriteNotifier.value
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Ləğv et', style: TextStyle(color: Colors.red)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text('Əlavə et', style: TextStyle(color: Colors.green)),
            onPressed: () {
              Navigator.of(context).pop();
              DatabaseService().addBook(
                Book(
                    imagePath: imagePathController.text,
                    name: nameController.text,
                    description: descriptionController.text,
                    price: double.tryParse(priceController.text) ?? 0.0,
                    isFavourite: _isFavouriteNotifier.value),
              );
            },
          ),
        ],
      );
    },
  );
}

TextField textFieldAlertDialog(TextEditingController controller, hint,
    {bool isNumber = false}) {
  return TextField(
    controller: controller,
    style: TextStyle(color: AppColors.secondColor),
    keyboardType: isNumber ? TextInputType.number : TextInputType.name,
    inputFormatters: <TextInputFormatter>[
      FilteringTextInputFormatter.allow(RegExp(
          isNumber ? r'^(\d+)?\.?\d{0,2}' : r'[a-zA-Z0-9_ .əƏşŞçÇöÖğĞüÜıI://]')),
    ],
    decoration: new InputDecoration(
      enabledBorder: const OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.primaryColor, width: 0.0),
      ),
      focusedBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.white60)),
      hintText: hint,
      hintStyle: TextStyle(color: Colors.white60),
    ),
  );
}
