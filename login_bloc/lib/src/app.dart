import 'package:flutter/material.dart';

class App extends StatelessWidget {
  build(BuildContext context) {
    return MaterialApp(
      title: 'Log me in!',
      home: Scaffold(
        body: LoginScreen(),
      ),
    );
  }
}
