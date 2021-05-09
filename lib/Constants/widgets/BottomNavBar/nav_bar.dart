import 'package:flutter/material.dart';

import 'nav_button.dart';
import 'nav_custom_painter.dart';

class CustomNavigationBar extends StatefulWidget {
  final List<Widget> items;
  final int initialIndex;
  final Color color;
  final Color buttonBackgroundColor;
  final Color backgroundColor;
  final ValueChanged<int> onTap;
  final Curve animationCurve;
  final Duration animationDuration;

  CustomNavigationBar(
      {
      required this.items,
      this.initialIndex = 0,
      this.color = Colors.white,
      required this.buttonBackgroundColor,
      this.backgroundColor = Colors.blueAccent,
      required this.onTap,
      this.animationCurve = Curves.easeOut,
      this.animationDuration = const Duration(milliseconds: 600)})
      : assert(items.length >= 2),
        assert(0 <= initialIndex && initialIndex < items.length);

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar>
    with SingleTickerProviderStateMixin {
  double _startingPos = 0;
  int _endingIndex = 0;
  double _pos = 0;
  double _buttonHide = 0;
  Widget _icon = Icon(Icons.home);
  late AnimationController _animationController;
  int _length = 0;

  @override
  void initState() {
    super.initState();
    _icon = widget.items[0];
    _length = widget.items.length;
    _pos = widget.initialIndex / _length;
    _startingPos = widget.initialIndex / _length;
    _animationController = AnimationController(vsync: this, value: _pos);
    _animationController.addListener(() {
      setState(() {
        _pos = _animationController.value;
        final endingPos = _endingIndex / widget.items.length;
        final middle = (endingPos + _startingPos) / 2;
        if ((endingPos - _pos).abs() < (_startingPos - _pos).abs()) {
          _icon = widget.items[_endingIndex];
        }
        _buttonHide =
            (1 - ((middle - _pos) / (_startingPos - middle)).abs()).abs();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: widget.backgroundColor,
      height: 50.0,
      child: Stack(
        clipBehavior: Clip.none,
        // overflow: Overflow.visible,
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Positioned(
            bottom: -70,
            left: _pos * size.width,
            width: size.width / _length,
            child: Center(
              child: Transform.translate(
                offset: Offset(
                  0,
                  -(1 - _buttonHide) * 70,
                ),
                child: Material(
                  color: widget.buttonBackgroundColor,
                  type: MaterialType.circle,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _icon,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomPaint(
              painter: NavCustomPainter(_pos, _length, widget.color),
              child: Container(height: 75.0),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
                height: 100.0,
                child: Row(
                    children: widget.items.map((item) {
                  return NavButton(
                    onTap: _buttonTap,
                    position: _pos,
                    length: _length,
                    index: widget.items.indexOf(item),
                    child: item,
                  );
                }).toList())),
          ),
        ],
      ),
    );
  }

  void _buttonTap(int index) {
    if (widget.onTap != null) {
      widget.onTap(index);
    }
    final newPosition = index / _length;
    setState(() {
      _startingPos = _pos;
      _endingIndex = index;
      _animationController.animateTo(newPosition,
          duration: widget.animationDuration, curve: widget.animationCurve);
    });
  }
}
