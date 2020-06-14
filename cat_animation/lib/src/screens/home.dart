import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat animation!'),
      ),
      body: buildAnimation(),
    );
  }

  Widget buildAnimation() {
    
  }
}
