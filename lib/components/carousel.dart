import 'package:flutter/material.dart';

const fullWidth = double.infinity;

class Carousel extends StatefulWidget {
  
  Carousel({
      @required this.height,
      @required this.items,
      @required this.padding,
      @required this.enableSelectionIndicator,
      this.key
      });

  final double height;
  final List<Widget> items;
  final double padding;
  final bool enableSelectionIndicator;
  final GlobalKey key;

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  
  int _currentSelection = 0;
  
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.height,
        width: fullWidth,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: widget.padding, bottom: 20.0, top: 10),
              child: Container(
                child: PageView(
                  controller: _pageController,
                  children: widget.items,
                  onPageChanged: (index) {
                    setState(() {
                      _currentSelection = index;
                    });
                  },
                ),
              ),
            ),
          widget.enableSelectionIndicator ? 
          Align(
            alignment: Alignment.bottomCenter,
            child: SelectedIndicator(numberOfDots: widget.items.length, currentSelection: _currentSelection)) : Container()
          ],
        ));
  }
}

class SelectedIndicator extends StatelessWidget {
  final int numberOfDots;
  final int currentSelection;

  SelectedIndicator({this.numberOfDots, this.currentSelection});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildDots(),
    );
  }

  Widget _createDot(bool selected) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.0),
      child: Container(
        height: 6.0,
        width: 6.0,
        decoration: BoxDecoration(
            color: selected ? Colors.lightGreen : Colors.grey[300],
            borderRadius: BorderRadius.circular(3.0)),
      ),
    );
  }

  List<Widget> _buildDots() {
    List<Widget> dots = [];
    for (int i = 0; i < numberOfDots; i++) {
      dots.add(i == currentSelection ? _createDot(true) : _createDot(false));
    }
    return dots;
  }
}