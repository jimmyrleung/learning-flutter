import 'package:flutter/material.dart';

class App extends StatelessWidget {
  // The build method returns the widgets that our custom widget use
  build(BuildContext context) {
    // MaterialApp sets up a lot of basic app configuration (specially the routing config)
    return MaterialApp(
      // home is the main route to our app and it shows a Text
      home: Scaffold(
        appBar: AppBar(
          title: Text('Lets see some images!'),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              print('Hello!');
            },
            child: Icon(Icons.add)),
      ), // prevent auto-indenting to a single line
    );
  }
}
