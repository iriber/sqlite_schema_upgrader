
import 'package:file_cache_provider/file_cache_provider.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    var fionaCache = FileCache(cacheFolder: "test/cache");
    var localPath = "";
    setUp(() {
      // Additional setup goes here.
    });

    test('Saving from URL', () async {
      String url =
          "https://storage.googleapis.com/cms-storage-bucket/ec64036b4eacc9f3fd73.svg";
      localPath = await fionaCache.getImagePath(url);
      print('Saving: $url to local path: $localPath');

      expect(true, isTrue);
    });

    test('Getting from local path', () async {
      String url =
          "https://storage.googleapis.com/cms-storage-bucket/ec64036b4eacc9f3fd73.svg";
      String localPath2 = await fionaCache.getImagePath(url);
      print('Getting: $localPath');
      expect((localPath == localPath2), isTrue);
    });
  });
}
