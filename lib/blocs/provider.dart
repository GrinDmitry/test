
import 'package:flutter/material.dart';
import 'package:test_ui/blocs/bloc.dart';
export 'package:test_ui/blocs/bloc.dart';

class Provider extends InheritedWidget {
  
  final bloc;

  Provider({Key key, Widget child}): bloc = Bloc(), super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static Bloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>().bloc);
  }
}