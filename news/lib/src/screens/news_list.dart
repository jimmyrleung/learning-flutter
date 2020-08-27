import 'package:flutter/material.dart';

class NewsList extends StatelessWidget {
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top news'),
      ),
      body: buildList(),
    );
  }

  Widget buildList() {
      return ListView.builder(
        itemCount: 1000,

        // represents each item that will be built
        // this works like a lazy loader because we can render it
        // conditionally
        itemBuilder: (context, int index) {
          return FutureBuilder(
            future: getFuture(),
            builder: (context, snapshot) {
              return Container(
                height: 80.0,
                child: snapshot.hasData
              ? Text("I'm visible, $index")
              : Text("I haven't fetched data yet $index"),
              );
            },
          );
        },
      );
  }

  Future<String> getFuture() {
    return Future.delayed(
      Duration(seconds: 2),
      () => 'Hi'
    );
  }
}
