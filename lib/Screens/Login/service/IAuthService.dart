import 'package:book_project/Screens/Login/model/signin_request_model.dart';
import 'package:book_project/Screens/Login/model/auth_response.dart';
import 'package:book_project/Screens/Login/model/signup_request_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<AuthResponseModel?> userLoginWithEmail(SignInRequestModel model);

  Future<AuthResponseModel?> userSignUpWithEmail(SignUpRequestModel model);

  Future<void> signOut();
}
