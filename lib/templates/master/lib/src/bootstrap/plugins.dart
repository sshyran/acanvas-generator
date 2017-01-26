part of rockdot_template;

///  The RdBootstrap class manages instantiation of and programmatic additions to our [ApplicationContext].
///  Most often, you will instantiate and load this class in [Entrypoint]

class Plugins {
  int _exampleOrder;
  List<IObjectFactoryPostProcessor> plugins;


  Plugins() {

    //----------------------------
    //Index for order of Examples. Starts with 1 because 0 is reserved for Home Page.
    _exampleOrder = 1;

    // The Plugins we want to use

    plugins = [

      //----------------------------

      // Mandatory Plugins

      new StatePlugin(),
      new ScreenDisplaylistPlugin(),

      //----------------------------

      //Optional Plugins
      
      new IOPlugin(),
      new GooglePlugin(),
      new FacebookPlugin(),
      //new UGCPlugin(),            /* persistency, requires Rockdot Zend backend */
      new BabylonPlugin(autoInit: true),

      //----------------------------

      // Autogenerated Plugins

      // ## PLUGIN INSERTION PLACEHOLDER - DO NOT REMOVE ## //

      //----------------------------
  
      // Examples

      //StageXL BitmapFont extension Examples
      new BitmapFontExamplePlugin(_exampleOrder++),

      //StageXL Examples
      new StagexlExamplePlugin(_exampleOrder++),

      //Rockdot Commons - Material Design Examples
      new MaterialExamplePlugin(_exampleOrder++),

      //StageXL DragonBones extension Examples
      new DragonBonesExamplePlugin(_exampleOrder++),

      //StageXL GAF extension Examples
      new GAFExamplePlugin(_exampleOrder++),

      //StageXL Spine extension Examples
      new SpineExamplePlugin(_exampleOrder++),

      //StageXL Flump extension Examples
      new FlumpExamplePlugin(_exampleOrder++),

      //StageXL Isometric extension Examples
      new IsometricExamplePlugin(_exampleOrder++),

      //StageXL Particle extension Examples
      new ParticleExamplePlugin(_exampleOrder++),

      //Rockdot Framework - Facebook API Examples
      new FacebookExamplePlugin(_exampleOrder++),

      //Rockdot Framework - Google API Examples
      new GoogleExamplePlugin(_exampleOrder++),

      //Rockdot Physics - Examples
      new PhysicsExamplePlugin(_exampleOrder++),

      //Rockdot Babylon - Examples
      new BabylonExamplePlugin(_exampleOrder++),

      //Rockdot Framework - User Generated Content Backend Examples
      //new UGCExamplePlugin(_exampleOrder++),

      // Our project. Contains the Home Page. It's a plugin, too!
      new Project()

    ];
  }

}
