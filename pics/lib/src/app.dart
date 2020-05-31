import 'dart:convert'; //json
import 'package:flutter/material.dart';
import 'package:http/http.dart' show get; // avoid importing the whole package
import './models/image_model.dart';
import 'widgets/image_list.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  int counter = 0;
  List<ImageModel> images = [];

  void fetchImage() async {
    counter++;
    String url = 'https://jsonplaceholder.typicode.com/photos/$counter';

    // res contains information about the http response (status code, headers, etc.)
    final res = await get(url);
    final img = ImageModel.fromJSON(json.decode(res.body));

    print(img);

    setState(() {
      images.add(img);
    });
  }

  // Use this when jsonplaceholder is unavailable
  void setMockImages() {
    counter++;

    final img = new ImageModel(
      id: counter,
      title: 'accusamus beatae ad facilis cum similique qui sunt',
      url: 'https://via.placeholder.com/600/92c952',
    );

    setState(() {
      images.add(img);
    });
  }

  // The build method returns the widgets that our custom widget use
  build(BuildContext context) {
    // MaterialApp sets up a lot of basic app configuration (specially the routing config)
    return MaterialApp(
      // home is the main route to our app and it shows a Text
      home: Scaffold(
        appBar: AppBar(
          title: Text('Lets see some images!'),
        ),
        body: ImageList(images),
        floatingActionButton:
            FloatingActionButton(onPressed: setMockImages, child: Icon(Icons.add)),
      ), // prevent auto-indenting to a single line
    );
  }
}
