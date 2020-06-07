import 'package:flutter/material.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
  final bloc = Bloc();

  Provider({Key key, Widget child})
  : super(key: key, child: child); // passing to InheritedWidget

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  // Considering the widget hierarchy, this function basically say:
  // Please flutter, get the closest 'Provider' instance and give me
  // its 'bloc' property
  static Bloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>()).bloc;
  }
}

