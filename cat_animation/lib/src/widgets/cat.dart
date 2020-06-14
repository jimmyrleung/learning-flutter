import 'package:flutter/material.dart';

class Cat extends StatelessWidget {
  build(BuildContext context) {
    return Image.network(
      'https://i.imgur.com/QwhZRyL.png',
      width: 250.0,
      height: 250.0,
    );
  }
}
