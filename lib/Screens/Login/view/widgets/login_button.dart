import 'package:book_project/Constants/colors.dart';
import 'package:book_project/Screens/Login/viewmodel/login/login_cubit.dart';
import 'package:book_project/Screens/Login/viewmodel/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget buildLoginButton(BuildContext baseContext) {
  var screenSize = MediaQuery.of(baseContext).size;

  return BlocConsumer<LoginCubit, LoginState>(
    listener: (context, state) {},
    builder: (context, state) {
      return ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(10),
          shadowColor: MaterialStateProperty.all<Color>(AppColors.primaryColor),
          backgroundColor:
              MaterialStateProperty.all<Color>(AppColors.primaryColor),
          maximumSize:
              MaterialStateProperty.all<Size>(Size(screenSize.width * 0.7, 50)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
        ),
        onPressed: context.watch<LoginCubit>().isLoading
            ? null
            : () {
                context.read<LoginCubit>().loginWithEmail();
              },
        child: ListTile(
          leading: context.watch<LoginCubit>().isLoading
              ? Container(
                  height: 30, width: 30, child: CircularProgressIndicator())
              : Icon(Icons.book, color: AppColors.white),
          title: Text(
            'Daxil ol',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
        ),
      );
    },
  );
}
