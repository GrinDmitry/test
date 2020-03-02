import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test_ui/constants.dart';

class Category extends StatelessWidget {
  final double rowHeight;
  final String categoryTitle;
  final String categoryButtonTitle;
  final Widget body;

  Category(
      {@required this.rowHeight,
      this.categoryTitle,
      this.categoryButtonTitle,
      @required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: rowHeight,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
              child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '$categoryTitle',
                    style: Constants.kCategoryTitleStyle
                  ),
                  FlatButton(
                    padding: EdgeInsets.only(right: 5),
                    onPressed: () {
                      print('there could be Navigator.push method');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '$categoryButtonTitle',
                          style: Constants.kCategoryButtonTitleStyle,
                        ),
                        Icon(
                          Icons.navigate_next,
                          size: 18,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: body,
            )
        ],
      ),
    );
  }
}