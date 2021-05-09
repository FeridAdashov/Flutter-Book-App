import 'package:book_project/Constants/colors.dart';
import 'package:book_project/Constants/functions.dart';
import 'package:book_project/Screens/Login/service/auth_service.dart';
import 'package:book_project/Screens/Login/view/login/login_page.dart';
import 'package:book_project/Services/DatabaseService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'ExtraPages/search_bar_page.dart';
import 'Sections/bottom_section.dart';
import 'Sections/choices_section.dart';
import 'Sections/main_section.dart';
import 'Sections/top_section.dart';
import 'model/book.dart';

class BookHome extends StatefulWidget {

  @override
  _BookHomeState createState() => _BookHomeState();
}

class _BookHomeState extends State<BookHome> {
  final AuthService _auth = AuthService();
  String _searchText = "";

  int _selectedBottomMenuIndex = 0;

  bool _topSectionVisibility = true;

  int _initialDragTimeStamp = 0;
  int _currentDragTimeStamp = 0;
  int _timeDelta = 0;
  double _initialPositionY = 0;
  double _currentPositionY = 0;
  double _positionYDelta = 0;

  List<String> listNames = List.generate(5, (index) => 'name: $index');

  void _startVerticalDrag(details) {
    _initialDragTimeStamp = details.sourceTimeStamp.inMilliseconds;
    _initialPositionY = details.globalPosition.dy;
  }

  void _whileVerticalDrag(details) {
    _currentDragTimeStamp = details.sourceTimeStamp.inMilliseconds;
    _currentPositionY = details.globalPosition.dy;

    _timeDelta = _currentDragTimeStamp - _initialDragTimeStamp;
    _positionYDelta = _currentPositionY - _initialPositionY;

    if (_timeDelta < 200 && _positionYDelta < -100) {
      setState(() {
        _topSectionVisibility = false;
      });
    } else if (_timeDelta < 200 && _positionYDelta > 100) {
      setState(() {
        _topSectionVisibility = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    void visibleTopSection(bool b) {
      setState(() {
        _topSectionVisibility = b;
      });
    }

    return MultiProvider(
      providers: [
        StreamProvider<List<Book>>.value(
          value: DatabaseService().booksList(),
          initialData: [],
        )
      ],
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onVerticalDragStart: (details) => _startVerticalDrag(details),
        onVerticalDragUpdate: (details) => _whileVerticalDrag(details),
        child: Scaffold(
          backgroundColor: AppColors.homeBaseColor,
          bottomNavigationBar: buildBottomSection(
            AppColors.homeBaseColor,
            AppColors.primaryColor,
            _selectedBottomMenuIndex,
            tapNavBar,
          ),
          body: Column(
            children: [
              TopSection(selected: _topSectionVisibility),
              ChoicesSection(),
              Expanded(
                  child: MainSection(visibleTopSection: visibleTopSection)),
              SizedBox(height: 5)
            ],
          ),
        ),
      ),
    );
  }

  tapNavBar(int index) {
    setState(() {
      _selectedBottomMenuIndex = index;
    });

    switch (index) {
      case 0:
        _auth.signOut();
        replacePage(context, LoginPage());
        break;
      case 1:
        showSearch(context: context, delegate: SearchBarPage(listNames));
        break;
      case 2:
        break;
    }
  }
}
