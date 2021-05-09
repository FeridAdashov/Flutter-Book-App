import 'package:flutter/material.dart';

class ChoicesSection extends StatefulWidget {
  @override
  _ChoicesSectionState createState() => _ChoicesSectionState();
}

class _ChoicesSectionState extends State<ChoicesSection> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<String> _listChoices = List.generate(0, (index) => 'name: $index');

    _listChoices.add('Hamısı');
    _listChoices.add('Ana Yeməklər');
    _listChoices.add('İçkilər');
    _listChoices.add('Pizza');
    _listChoices.add('Desert');
    _listChoices.add('Şiriniyyat');

    return Container(
      height: 60.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(_listChoices.length, (int index) {
          return Center(
            child: Container(
              margin: EdgeInsets.only(left: 5),
              padding: EdgeInsets.only(left: 10, right: 10),
              child: GestureDetector(
                onTap: () => setState(() {
                  _selectedIndex = index;
                }),
                child: Text(
                  "${_listChoices.elementAt(index)}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color:
                        _selectedIndex == index ? Color(0xFF3D6602) : Color(
                            0xEE6A9C2D),
                    fontWeight: FontWeight.bold,
                    fontSize: _selectedIndex == index ? 18 : 15
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
