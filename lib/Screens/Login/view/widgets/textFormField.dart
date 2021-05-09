import 'package:book_project/Constants/colors.dart';
import 'package:flutter/material.dart';

Widget buildTextFormField(
  TextEditingController controller, {
  String label = '',
  String validateText = '',
  bool isPassword = false,
  Icon? icon,
}) {
  ValueNotifier<bool> _hasText = ValueNotifier(true);

  _updateTextStatus(String text) {
    _hasText.value = text == "";
  }

  return ValueListenableBuilder(
    valueListenable: _hasText,
    builder: (BuildContext context, bool hasError, Widget? child) {
      return TextFormField(
        style: TextStyle(color: Colors.black54),
        obscureText: isPassword,
        controller: controller,
        validator: (value) => (value ?? '').length > 6 ? null : validateText,
        onChanged: _updateTextStatus,
        decoration: InputDecoration(
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor, width: 10)),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor),
          ),
          labelText: label,
          labelStyle: TextStyle(
            color: Color(0xFF3A92DE),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          suffixIcon: _hasText.value
              ? icon ??
                  Icon(Icons.warning_amber_outlined,
                      color: AppColors.primaryColor)
              : IconButton(
                  color: AppColors.primaryColor,
                  onPressed: () {
                    controller.clear();
                    _updateTextStatus('');
                  },
                  icon: Icon(Icons.clear),
                ),
        ),
      );
    },
  );
}
