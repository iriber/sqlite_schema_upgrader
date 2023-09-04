import 'package:file_cache_provider/file_cache_provider.dart';

void main() {
  var fionaCache = FileCache();
  String url =
      "https://storage.googleapis.com/cms-storage-bucket/ec64036b4eacc9f3fd73.svg";
  fionaCache.save(url);
  print('Saving: $url');
}
