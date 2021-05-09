class SignInRequestModel {
  String? email;
  String? password;

  SignInRequestModel({this.email, this.password});

  String? get getEmail => email;
  String? get getPassword => password;
}
