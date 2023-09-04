class CachedFile {
  /// Object identification.
  int id = -1;

  /// Url of the cached file.
  String url = "";

  /// Local name of the cached file.
  String localName = "";

  /// Builds an object.
  CachedFile(id, this.url, this.localName);

  /// Creates an empty object.
  CachedFile.empty();

  /// Build an object from a json map.
  CachedFile.fromMap(Map<String, dynamic> item) {
    id = item["id"];
    url = item["url"];
    localName = item["localName"];
  }

  /// Returns the object as a json map.
  Map<String, Object> toMap() {
    return {'id': id, 'url': url, 'localName': localName};
  }

  /// Returns true if the object has not set an id.
  bool isEmpty() => id == -1;
}
