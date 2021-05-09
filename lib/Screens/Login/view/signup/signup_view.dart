import 'package:book_project/Constants/colors.dart';
import 'package:book_project/Constants/functions.dart';
import 'package:book_project/Screens/Home/home_page.dart';
import 'package:book_project/Screens/Login/service/auth_service.dart';
import 'package:book_project/Screens/Login/view/widgets/back_shape.dart';
import 'package:book_project/Screens/Login/view/widgets/signup_button.dart';
import 'package:book_project/Screens/Login/viewmodel/signup/signup_cubit.dart';
import 'package:book_project/Screens/Login/viewmodel/signup/signup_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/textFormField.dart';

class SignupView extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext baseContext) {
    return BlocProvider(
      create: (context) => SignupCubit(
        formKey,
        nameController,
        emailController,
        passwordController,
        service: AuthService(),
      ),
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state is SignupComplete) {
            replacePage(context, HomePage(model: state.model));
          } else if (state is SignupError) {
            showFloatingFlushbar(baseContext, 'Signup Error', state.message);
            print("ERROR: ${state.message}");
          }
        },
        builder: (context, state) {
          return buildScaffold(context, state);
        },
      ),
    );
  }

  Scaffold buildScaffold(BuildContext context, SignupState state) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.secondColor,
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              fit: StackFit.expand,
              children: [
                CustomPaint(painter: CustomShapeClass(screenSize)),
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/images/book.svg',
                        height: screenSize.height * 0.3,
                      ),
                      Container(
                        width: screenSize.width * 0.5,
                        alignment: Alignment.center,
                        child: Text(
                          'KitApp',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      Container(
                        width: screenSize.width * 0.9,
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            bottomLeft: Radius.circular(40),
                          ),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(5, 5), color: Color(0x378573E0)),
                          ],
                        ),
                        child: Column(
                          children: [
                            buildTextFormField(nameController,
                                label: 'Ad',
                                validateText: 'Simvol sayı 5-dən azdır',
                                icon: Icon(Icons.drive_file_rename_outline,
                                    color: AppColors.primaryColor)),
                            SizedBox(height: 10),
                            buildTextFormField(emailController,
                                label: 'Email',
                                validateText: 'Simvol sayı 6-dan azdır',
                                icon: Icon(Icons.email_outlined,
                                    color: AppColors.primaryColor)),
                            SizedBox(height: 10),
                            buildTextFormField(passwordController,
                                label: 'Şifrə',
                                validateText: 'Simvol sayı 6-dan azdır',
                                isPassword: true,
                                icon: Icon(Icons.vpn_key,
                                    color: AppColors.primaryColor)),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      buildSignupButton(context),
                      SizedBox(height: 10)
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: AppColors.white),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
