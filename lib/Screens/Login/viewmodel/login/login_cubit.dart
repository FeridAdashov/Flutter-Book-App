import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../model/signin_request_model.dart';
import '../../model/auth_response.dart';
import '../../service/IAuthService.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  final IAuthService service;

  bool isLoginFail = false;
  bool isLoading = false;

  LoginCubit(this.formKey, this.emailController, this.passwordController,
      {required this.service})
      : super(LoginInitial());

  Future<void> loginWithEmail() async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      changeLoadingView();

      var data;
      try {
        data = await service.userLoginWithEmail(SignInRequestModel(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        ));
      } catch (e) {
        emit(LoginError('Login Error: ' + e.toString()));
        changeLoadingView();
        return;
      }

      if (data is AuthResponseModel)
        emit(LoginComplete(data));
      else
        emit(LoginError("LOGIN ERROR"));

      changeLoadingView();
    } else {
      isLoginFail = true;
      emit(LoginValidateState(isLoginFail));
    }
  }

  void changeLoadingView() {
    isLoginFail = false;
    isLoading = !isLoading;
    emit(LoginLoadingState(isLoading));
  }
}
