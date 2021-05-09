class SignUpRequestModel {
  String? name;
  String? email;
  String? password;

  SignUpRequestModel({this.name, this.email, this.password});

  String? get getName => name;
  String? get getEmail => email;
  String? get getPassword => password;
}
