import 'package:book_project/Screens/Login/model/user_model.dart';
import 'package:book_project/Services/DatabaseService.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthResponseModel {
  User? user;
  UserModel? userModel;

  AuthResponseModel({this.userModel});

  AuthResponseModel.getUserData(this.user) {
    setUserData();
  }

  Future<void> setUserData() async {
    userModel = await DatabaseService().userDataByEmail(user!.email);
  }
}
