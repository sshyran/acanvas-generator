part of acanvas_generator;

class ElementCommand extends AcanvasCommand {
  static final String DEFAULT_ELEMENT_NAME = "GeneratedElement";

  static final String TEMPLATE_ELEMENT_FILE = "element.dart";
  static final String PACKAGE_REPLACE_STRING = "@package@";
  static final String ELEMENT_REPLACE_STRING = "@element@";
  static final String ELEMENT_PROPERTY_REPLACE_STRING = "@elementproperty@";

  static final String DIR_LIB = "lib";
  static final String DIR_PROJECT = "$DIR_LIB/src/project";
  static final String DIR_ELEMENT = "$DIR_PROJECT/view/element";
  static final String DIR_PROPERTIES = "$DIR_LIB/config/locale/en";

  static final String ELEMENT_INSERTION_PLACEHOLDER =
      "// ## ELEMENT INSERTION PLACEHOLDER - DO NOT REMOVE ## //";
  static final String ELEMENT_PROPERTIES_PLACEHOLDER =
      "## ELEMENT INSERTION PLACEHOLDER - DO NOT REMOVE ##";

  String targetPath;
  String elementUrl;
  String elementNameDashed;
  String elementNameCamelCase;
  String elementNameUnderscored;
  String elementNameUnderscoredUppercase;

  ElementCommand(CliLogger logger, Target writeTarget)
      : super(logger, writeTarget) {
    packageName = _getPackageNameFromPubspec();
    name = "element";
    description = "Create a view Element class. Also adds Properties.";

    argParser.addOption('name',
        abbr: 'n',
        defaultsTo: DEFAULT_ELEMENT_NAME,
        help: 'The name (in CamelCase) of the view element to be generated.',
        valueHelp: 'name', callback: (_commandName) {
      elementNameCamelCase = _commandName;
    });

    argParser.addOption('target',
        abbr: 't',
        defaultsTo: DIR_ELEMENT,
        help: 'The target path of the view element to be generated.',
        valueHelp: 'target', callback: (_path) {
      targetPath = _path;
    });
  }

  @override
  void run() async {
    elementNameDashed = _getDashed();
    elementNameUnderscored = _getUnderscored();
    elementNameUnderscoredUppercase = elementNameUnderscored.toUpperCase();

    String targetFile = join(targetPath, '$elementNameUnderscored.dart');

    // just decode skeletons_data.data["assets.dart"]
    String assetClassFilePath =
        skeletons_data.data.firstWhere((path) => path == TEMPLATE_ELEMENT_FILE);

    List<TemplateFile> templates = await decodeConcanenatedData(
        <String>[assetClassFilePath], skeletons_data.type);

    TemplateFile templateFile = templates.first;
    templateFile.path = targetFile;

    //add command from template to DIR_COMMAND
    templateFile.content = templateFile.content
        .replaceAll(new RegExp(ELEMENT_REPLACE_STRING), elementNameCamelCase);
    templateFile.content = templateFile.content
        .replaceAll(new RegExp(PACKAGE_REPLACE_STRING), packageName);

    addTemplateFile(templateFile);

    //this writes to templateFile.content
    logger.stdout(
        "Writing Element class '$elementNameCamelCase' to file '$targetFile'.");
    await generate(_getPackageNameFromPubspec());

    //add const to events
    _insertProperties();

    //add class name to package spec $DIR_LIB/$packageName.dart
    _addToPackage();

    logger.stdout(
        "Done. You can now access your new Element class named ${elementNameCamelCase}");
  }

  void _insertProperties() {
    String replace = '''##############################
### Element: $elementNameUnderscoredUppercase
##############################
element.$elementNameUnderscored.headline = Hello World.
element.$elementNameUnderscored.copy = See config/locale for text associated to autogenerated class $elementNameCamelCase

$ELEMENT_PROPERTIES_PLACEHOLDER
''';

    String path = "$DIR_PROPERTIES/en.properties";

    File file = new File(path);
    String fileContent = file.readAsStringSync();
    fileContent = fileContent.replaceFirst(
        new RegExp(ELEMENT_PROPERTIES_PLACEHOLDER), replace);
    file.writeAsStringSync(fileContent);
  }

  void _addToPackage() {
    String replace =
        "part 'src/project/view/element/$elementNameUnderscored.dart';\n$ELEMENT_INSERTION_PLACEHOLDER";

    File file = new File("$DIR_LIB/$packageName.dart");
    String fileContent = file.readAsStringSync();
    fileContent = fileContent.replaceFirst(
        new RegExp(ELEMENT_INSERTION_PLACEHOLDER), replace);
    file.writeAsStringSync(fileContent);
  }

  String _getDashed() {
    return elementNameCamelCase
        .replaceAllMapped(new RegExp("([^A-Z-])([A-Z])"),
            (Match m) => (m.group(1) + "-" + m.group(2)))
        .toLowerCase();
  }

  String _getUnderscored() {
    return elementNameCamelCase
        .replaceAllMapped(new RegExp("([^A-Z-])([A-Z])"),
            (Match m) => (m.group(1) + "_" + m.group(2)))
        .toLowerCase();
  }
}
