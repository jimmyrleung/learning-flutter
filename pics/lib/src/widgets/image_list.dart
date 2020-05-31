import 'package:flutter/material.dart';
import '../models/image_model.dart';

// The image list won't maintain the list, it will only
// render a list of given images, so that's why we define
// that widget as Stateless
class ImageList extends StatelessWidget {
  // Considering that it is a stateless widget, flutter want us to
  // explicit say that we don't plan to change that property
  final List<ImageModel> images;

  ImageList(this.images);

  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: images.length,
      itemBuilder: (context, int index) {
        return buildImage(images[index]);
      },
    );
  }

  Widget buildImage(ImageModel img) {
    return Container(
      // EdgeInsets: each 'edge' of the element
      // all: apply for all
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Padding(
            child: Image.network(img.url),
            padding: EdgeInsets.only(bottom: 10.0),
          ),
          Text(
            img.title,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      decoration: BoxDecoration(
          border: Border.all(
        color: Colors.grey,
      )),
    );
  }
}
