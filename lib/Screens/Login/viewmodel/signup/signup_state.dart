import 'package:book_project/Screens/Login/model/auth_response.dart';

abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupComplete extends SignupState {
  final AuthResponseModel model;

  SignupComplete(this.model);
}

class SignupValidateState extends SignupState {
  final bool isValidate;

  SignupValidateState(this.isValidate);
}

class SignupLoadingState extends SignupState {
  final bool isLoading;

  SignupLoadingState(this.isLoading);
}

class SignupError extends SignupState {
  final String message;

  SignupError(this.message);
}
