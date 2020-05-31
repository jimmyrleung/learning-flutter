class ImageModel {
  int id;
  String url;
  String title;
  
  ImageModel({this.id, this.url, this.title});
  
  ImageModel.fromJSON(Map<String, dynamic> parsedJSON) {
    id = parsedJSON['id'];
    url = parsedJSON['url'];
    title = parsedJSON['title'];
  }

  // shorter form (not recommended, but you better know)
  // ImageModel.fromJSON(Map<String, dynamic> parsedJSON) :
  //   id = parsedJSON['id'],
  //   url = parsedJSON['url'],
  //   title = parsedJSON['title'];

  @override
  String toString() {
    return '$id - $title - $url';
  }
}