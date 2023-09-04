import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:io' as io;

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:crypto/crypto.dart';

import 'cached_file.dart';

class FileCache {

  /// Default folder where the files will be saved.
  final String defaultCacheFolder = "fiona_cache";

  /// Cache folder where the files will be saved.
  String cacheFolder;

  /// Builds an object.
  FileCache({this.cacheFolder=""});

  /// Gets an image from an Url and saves it.
  FutureOr<CachedFile> save(String url) async {
    String encodedUrl = Uri.encodeFull(url);

    CachedFile? cacheFile = _getLocalFile(encodedUrl);

    return cacheFile??await _downloadAndSave(url);
  }

  String _getLocalName(String url) {
    String extension = "dat";
    if (url.split(".").isNotEmpty) {
      extension = url.split(".").last;
    }
    var urlInBytes = utf8.encode(url);
    String value = sha256.convert(urlInBytes).toString();
    String localName = "$value.$extension";
    return localName;
  }

  FutureOr<CachedFile> _downloadAndSave(String url) async {
    String encodedUrl = Uri.encodeFull(url);

    String localName = _getLocalName(encodedUrl);

    CachedFile cacheFile = CachedFile(-1, encodedUrl, localName);

    await _downloadImage(url, _getLocalPath(cacheFile));

    return cacheFile;
  }

  FutureOr<dynamic> _downloadImage(String url, String localPath) async {
    File(localPath).createSync(recursive: true);
    File file = File(localPath);
    var bytes = await getFileBytes(url);
    await file.writeAsBytes(bytes);
    return bytes;
  }

  String _getCacheFolder() {
    String path = cacheFolder.isEmpty ? defaultCacheFolder : cacheFolder;
    return path;
  }

  String _getLocalPath(CachedFile cacheFile) {

    String localPath = path.join(_getCacheFolder(), cacheFile.localName);
    return localPath;
  }

  /// Returns image path from an Url.
  FutureOr<String> getImagePath(String url) async {
    CachedFile cacheFile = await save(url);
    return _getLocalPath(cacheFile);
  }

  /// Returns image bytes from an Url.
  FutureOr<dynamic> getFileBytes(url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var bytes = response.bodyBytes;
      return bytes;
    } else {
      throw Exception("File not found $url");
    }
  }

  /// Cleans cache.
  FutureOr<void> cleanCache() async {}

  CachedFile? _getLocalFile(String encodedUrl) {
    String localname = _getLocalName(encodedUrl);
    if (io.File(localname).existsSync()) {
      return CachedFile(-1, encodedUrl, _getLocalName(encodedUrl));
    }else{
      return null;
    }
  }
}
