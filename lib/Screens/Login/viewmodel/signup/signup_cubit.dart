import 'package:bloc/bloc.dart';
import 'package:book_project/Screens/Login/model/signup_request_model.dart';
import 'package:book_project/Screens/Login/model/user_model.dart';
import 'package:book_project/Services/DatabaseService.dart';
import 'package:flutter/material.dart';

import '../../model/auth_response.dart';
import '../../service/IAuthService.dart';
import 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  final IAuthService service;

  bool isLoginFail = false;
  bool isLoading = false;

  SignupCubit(
    this.formKey,
    this.nameController,
    this.emailController,
    this.passwordController, {
    required this.service,
  }) : super(SignupInitial());

  Future<void> signupWithEmail() async {
    print(formKey.currentState);
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      changeLoadingView();

      var requestModel = SignUpRequestModel(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      var data;
      try {
        data = await service.userSignUpWithEmail(requestModel);
        await DatabaseService().setUserData(UserModel(
            name: requestModel.name!,
            email: requestModel.email!,
            password: requestModel.password!));
      } catch (e) {
        emit(SignupError(e.toString()));
        changeLoadingView();
        return;
      }

      if (data is AuthResponseModel)
        emit(SignupComplete(data));
      else
        emit(SignupError("LOGIN ERROR"));

      changeLoadingView();
    } else {
      isLoginFail = true;
      emit(SignupValidateState(isLoginFail));
    }
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(SignupLoadingState(isLoading));
  }
}
