import 'package:flutter/material.dart';
import 'package:test_ui/constants.dart';
import 'package:test_ui/main.dart';

class SlideUpMenu extends StatefulWidget {
  final double menuHeight;
  final Widget content;
  final double initialPosition;

  SlideUpMenu(
      {@required this.menuHeight,
      @required this.initialPosition,
      this.content});

  @override
  _SlideUpMenuState createState() => _SlideUpMenuState();
}

class _SlideUpMenuState extends State<SlideUpMenu>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _ac;
  double _position;
  Size size;
  Offset offset;

  @override
  void initState() {
    super.initState();

    _position = widget.initialPosition;

    _ac =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));

    _animation = CurvedAnimation(parent: _ac, curve: Curves.bounceInOut);
    _animation.addListener(() {
      setState(() {
        _position = widget.initialPosition;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _gestureHandler(
        child: SafeArea(
      child: Stack(
        children: <Widget>[
          Positioned(
            top: _position,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(2, 2),
                        blurRadius: 3)
                  ]),
              height: widget.menuHeight,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 8),
                  Container(width: 30, height: 3, color: Colors.grey[300]),
                  SizedBox(
                    height: 20,
                  ),
                  widget.content != null ? widget.content : Container()
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }

  Widget _gestureHandler({Widget child}) {
    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details) =>
          _onGestureSlide(details.globalPosition.dy),
      onPanEnd: (DragEndDetails details) => _ac.fling(),
      child: child,
    );
  }

  void _onGestureSlide(double dy) {
    setState(() {
      _position = dy;
    });
  }
}

Widget gridView() {
  return Expanded(
    child: GridView.count(
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      children: <Widget>[
        _setButton(
            image: Constants.topUp,
            name: 'Top up',
            onPress: () {
              navigatorKey.currentState.pushNamed('/onTopUp');
            }),
        _setButton(image: Constants.toCard, name: 'To Card', onPress: null),
        _setButton(image: Constants.payments, name: 'Payments', onPress: null),
        _setButton(image: Constants.addService, name: 'Add', onPress: null),
      ],
    ),
  );
}

Widget _setButton({Image image, String name, Function onPress}) {
  return Column(
    mainAxisSize: MainAxisSize.max,
    children: <Widget>[
      IconButton(
        icon: image,
        onPressed: onPress,
        iconSize: 48,
      ),
      Text(name, style: TextStyle(fontSize: 12, fontFamily: 'SanFrancisco'))
    ],
  );
}
