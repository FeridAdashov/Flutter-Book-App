import 'package:book_project/Constants/colors.dart';
import 'package:book_project/Constants/strings.dart';
import 'package:book_project/Constants/widgets/loading_indicator.dart';
import 'package:book_project/Screens/Login/model/auth_response.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final AuthResponseModel model;

  const HomePage({Key? key, required this.model}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: initialize(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return LoadingPage();
          default:
            return Scaffold(
                backgroundColor: AppColors.secondColor,
                appBar: AppBar(
                  title: Text(
                    AppStrings.APP_NAME,
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                  backgroundColor: AppColors.secondColor,
                  elevation: 0.0,
                ),
                body: snapshot.hasError
                    ? Center(child: Text('Error: ${snapshot.error}'))
                    : ScaffoldBody(widget.model));
        }
      },
    );
  }

  Future<void> initialize() async {
    if (widget.model.userModel == null) await widget.model.setUserData();
  }
}

class ScaffoldBody extends StatelessWidget {
  ScaffoldBody(AuthResponseModel model);

  @override
  Widget build(BuildContext context) {
    return Text('');
  }
}
