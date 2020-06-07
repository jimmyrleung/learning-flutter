import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'blocs/provider.dart';

class App extends StatelessWidget {
  build(BuildContext context) {
    // Every widget below the tree from here will have access
    // to Provider's BLOC
    return Provider(
      child: MaterialApp(
        title: 'Log me in!',
        home: Scaffold(
          body: LoginScreen(),
        ),
      ),
    );
  }
}
