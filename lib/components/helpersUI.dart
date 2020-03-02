import 'package:flutter/material.dart';
import 'package:test_ui/constants.dart';
import 'package:test_ui/blocs/bloc.dart';

getPrefixIcon() {
  return Row(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      IconButton(icon: Constants.ukraineFlag, onPressed: null),
      Text(
        '+380',
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
      Icon(
        Icons.chevron_right,
        color: Colors.grey,
      )
    ],
  );
}

getColor(int selection, [int index]) {
  if (index == null) {
    return Colors.transparent;
  } else if (index == selection) {
    return Colors.lightGreen;
  } else {
    return Colors.transparent;
  }
}

getThemeData() {
  return ThemeData(
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.lightGreen, width: 1.0),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 0.0),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent, width: 0.0),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent, width: 0.0),
      ),
    ),
  );
}

getSumOptionButton(int sumOption, Bloc bloc) {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Ink(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[200],
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(1000.0),
            onTap: () {
              bloc.updateSum('$sumOption');
            },
            child: Container(
              height: 35,
              width: 35,
              child: Center(
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text('$sumOption',
                      style: TextStyle(color: Colors.grey, fontSize: 10)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }