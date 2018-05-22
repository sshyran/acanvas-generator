part of spine_example;

///This class is autogenerated by executing 'pub run collect_assets' in your project's root.
///It collects all images from web/assets
class SpineAssets {
  static BitmapData get atlas {
    return _singleton.mgr.getBitmapData("atlas");
  }

  static BitmapData get flash {
    return _singleton.mgr.getBitmapData("flash");
  }

  static BitmapData get front_features {
    return _singleton.mgr.getBitmapData("front-features");
  }

  static BitmapData get front_what_is_spine {
    return _singleton.mgr.getBitmapData("front-what-is-spine");
  }

  static BitmapData get xml {
    return _singleton.mgr.getBitmapData("xml");
  }

  ResourceManager mgr = new ResourceManager();
  static BitmapData getBitmapData(String id) {
    return _singleton.mgr.getBitmapData(id);
  }

  static final SpineAssets _singleton = new SpineAssets._internal();

  factory SpineAssets() {
    return _singleton;
  }

  SpineAssets._internal() {}

  static Future load() async {
    _singleton.mgr.addBitmapData("atlas", "assets/spine/home/atlas.png");
    _singleton.mgr.addBitmapData("flash", "assets/spine/home/flash.png");
    _singleton.mgr.addBitmapData(
        "front-features", "assets/spine/home/front-features.jpg");
    _singleton.mgr.addBitmapData(
        "front-what-is-spine", "assets/spine/home/front-what-is-spine.jpg");
    _singleton.mgr.addBitmapData("xml", "assets/spine/home/xml.png");

    _singleton.mgr.load();
  }
}