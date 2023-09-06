
This package helps your app to cache files when get them from an URI.

## Features

FileCache downloads the image and saves it into your local path.
The next time the app read the same image, it will return the local path.

The Pro is that you manage the downloaded files, you decide when to clear this cache instead
of the cache managed by the device.


## Getting started

It's very simple to use, you only have to define the cache folder name where you want to save
the downloaded files.

## Usage

You have to create the cache file and the local path (optional) where you want to download the files:

```dart
/* create cache */
var fileCache = FileCache();
```
You can use fileCache to get the file path from an url.
The first time, the cache will get the file from the url, download it & save it.
The next time you call this method with the same url, the cache will return the local uri of the file.

```dart
/* Example: get an image from cache */
Image getImageLocalPath( ) async {
 
  // get file path from cache
  String imagePath = await fileCache.getFilePath(url);

  /* and then you can create an image from the imagePath (local uri) */
  Image image = Image.file(File(imagePath));
  image.image.resolve(ImageConfiguration()).addListener(
    ImageStreamListener((ImageInfo image, bool synchronousCall) {
      var myImage = image.image;
      Size size = Size(myImage.width.toDouble(), myImage.height.toDouble());
      completer.complete(ImageCacheInfo(size, imagePath));
    },
    ),
  );
  return image;
}
```


