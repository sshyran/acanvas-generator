import 'dart:io';
import 'package:args/args.dart';
import 'package:path/path.dart';

final String TEMPLATE_DIR = "bin/template";
const String TEMPLATE_COMMAND_FILE = "element.dart.tpl";
const String PACKAGE_REPLACE_STRING = "@package@";
const String ELEMENT_REPLACE_STRING = "@element@";
const String ELEMENT_PROPERTY_REPLACE_STRING = "@elementproperty@";

const String DEFAULT_ELEMENT_NAME = "";
const String ELEMENT_INSERTION_PLACEHOLDER =
    "// ## ELEMENT INSERTION PLACEHOLDER - DO NOT REMOVE ## //";
const String ELEMENT_PROPERTIES_PLACEHOLDER =
    "## ELEMENT INSERTION PLACEHOLDER - DO NOT REMOVE ##";

const String DIR_PROPERTIES = "config/locale";
const String DIR_LIB = "lib";
const String DIR_PROJECT = "$DIR_LIB/src/project";
const String DIR_SCREEN = "$DIR_PROJECT/view/element";
const String DIR_MODEL = "$DIR_PROJECT/model";

const String DEFAULT_ELEMENT_ROOT = DIR_LIB;

String elementNameDashed;
String elementNameCamelCase;
String elementNameUnderscored;
String elementNameUnderscoredUppercase;
String elementRoot;
String elementDir;

String packageName;

void main(List<String> args) {
  _setupArgs(args);

  if (elementNameCamelCase == DEFAULT_ELEMENT_NAME) {
    print(
        "Well, at least provide the --name of the Element you want to add, in CamelCase, will you?");
    exit(1);
  }

  packageName = _getPackageNameFromPubspec();
  elementNameDashed = _getElementNameDashed();
  elementNameUnderscored = _getElementNameUnderscored();
  elementNameUnderscoredUppercase = elementNameUnderscored.toUpperCase();

  if (elementRoot != DEFAULT_ELEMENT_ROOT) {
    elementDir = "src/view/element";
  } else {
    elementDir = "src/project/view/element";
  }

  //add const to events
  _insertProperties();

  //add command from template to DIR_SCREEN
  _createElementFile();

  //add class name to package spec $DIR_LIB/$packageName.dart
  _addToPackage();

  print(
      "Done. You can now access your new Element class named ${elementNameCamelCase}");
}

/// Adds the newly created library as dependency to the project's root pubspec.yaml.
String _getPackageNameFromPubspec() {
  if (elementRoot != DIR_LIB) {
    Directory dir = new Directory(elementRoot);
    File file = dir
        .listSync(followLinks: false)
        .where((entity) => entity is File)
        .first;
    String content = file.readAsStringSync();
    return new RegExp("library\\s*(\\w+);").firstMatch(content).group(1);
  } else {
    File pubspecRootFile = new File('pubspec.yaml').absolute;
    String pubspecRootFileContent = pubspecRootFile.readAsStringSync();
    return new RegExp("name\\s*:\\s*(\\w+)")
        .firstMatch(pubspecRootFileContent)
        .group(1);
  }
}

String _getElementNameDashed() {
  return elementNameCamelCase
      .replaceAllMapped(new RegExp("([^A-Z-])([A-Z])"),
          (Match m) => (m.group(1) + "-" + m.group(2)))
      .toLowerCase();
}

String _getElementNameUnderscored() {
  return elementNameCamelCase
      .replaceAllMapped(new RegExp("([^A-Z-])([A-Z])"),
          (Match m) => (m.group(1) + "_" + m.group(2)))
      .toLowerCase();
}

void _insertProperties() {
  String replace = '''##############################
### Element: $elementNameUnderscoredUppercase
##############################
element.$elementNameUnderscored.headline = Hello World.
element.$elementNameUnderscored.copy = See config/locale for text associated to autogenerated class $elementNameCamelCase

$ELEMENT_PROPERTIES_PLACEHOLDER
''';

  String path = (elementRoot != DIR_LIB)
      ? "$elementRoot/$DIR_PROPERTIES/en.properties"
      : "$DIR_PROPERTIES/en.properties";

  File file = new File(path);
  String fileContent = file.readAsStringSync();
  fileContent = fileContent.replaceFirst(
      new RegExp(ELEMENT_PROPERTIES_PLACEHOLDER), replace);
  file.writeAsStringSync(fileContent);
}

/// Copies Screen template file from [TEMPLATE_DIR] to [DIR_SCREEN].
/// During the process, all occurences of [ELEMENT_REPLACE_STRING] and [PACKAGE_REPLACE_STRING] are replaced.
void _createElementFile() {
  File file = new File("$TEMPLATE_DIR/$TEMPLATE_COMMAND_FILE");
  String fileContent = file.readAsStringSync();
  fileContent = fileContent.replaceAll(
      new RegExp(ELEMENT_REPLACE_STRING), elementNameCamelCase);
  fileContent =
      fileContent.replaceAll(new RegExp(PACKAGE_REPLACE_STRING), packageName);
  fileContent = fileContent.replaceAll(
      new RegExp(ELEMENT_PROPERTY_REPLACE_STRING), elementNameUnderscored);

  new File(join(elementRoot, elementDir, "$elementNameUnderscored.dart"))
    ..createSync(recursive: true)
    ..writeAsStringSync(fileContent);
}

void _addToPackage() {
  String replace = '''part '${elementDir}/$elementNameUnderscored.dart';
    $ELEMENT_INSERTION_PLACEHOLDER
  ''';

  File file = new File("$elementRoot/$packageName.dart");
  String fileContent = file.readAsStringSync();
  fileContent = fileContent.replaceFirst(
      new RegExp(ELEMENT_INSERTION_PLACEHOLDER), replace);
  file.writeAsStringSync(fileContent);
}

/// Manages the script's arguments and provides instructions and defaults for the --help option.
void _setupArgs(List<String> args) {
  ArgParser argParser = new ArgParser();

  argParser.addOption('name',
      abbr: 'n',
      defaultsTo: DEFAULT_ELEMENT_NAME,
      help: 'The name (in CamelCase) of the element to be generated.',
      valueHelp: 'name', callback: (_screenName) {
    elementNameCamelCase = _screenName;
  });

  argParser.addOption('root',
      abbr: 'r',
      defaultsTo: DEFAULT_ELEMENT_ROOT,
      help: 'The lib directory of the element to be generated.',
      valueHelp: 'root', callback: (_screenRoot) {
    elementRoot = _screenRoot;
  });

  argParser.addFlag('help', negatable: false, help: 'Displays the help.',
      callback: (help) {
    if (help) {
      print(argParser.usage);
      exit(1);
    }
  });

  argParser.parse(args);
}