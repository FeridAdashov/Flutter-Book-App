import 'package:book_project/Screens/Login/model/signup_request_model.dart';
import 'package:book_project/Screens/Login/model/user_model.dart';
import 'package:book_project/Services/DatabaseService.dart';

import '../model/auth_response.dart';
import '../model/signin_request_model.dart';
import 'IAuthService.dart';

class AuthService extends IAuthService {
  @override
  Future<AuthResponseModel?> userLoginWithEmail(
      SignInRequestModel model) async {
    final response = await auth.signInWithEmailAndPassword(
        email: model.email!, password: model.password!);

    if (response.user != null) {
      return AuthResponseModel.getUserData(response.user!);
    } else {
      return AuthResponseModel();
    }
  }

  @override
  Future<AuthResponseModel?> userSignUpWithEmail(
      SignUpRequestModel model) async {
    final response = await auth.createUserWithEmailAndPassword(
        email: model.email!, password: model.password!);

    await DatabaseService().setUserData(
      UserModel(
        name: model.name!,
        email: model.email!,
        password: model.password!,
      ),
    );

    if (response.user != null) {
      return AuthResponseModel.getUserData(response.user!);
    } else {
      return AuthResponseModel();
    }
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();
  }

  bool isSigned() {
    return auth.currentUser != null;
  }
}
