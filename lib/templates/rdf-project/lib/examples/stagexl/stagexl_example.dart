library stagexl_example;

import 'dart:math' hide Point;
import 'dart:async' show StreamSubscription, Future, Completer;

import 'package:stagexl/stagexl.dart';
import 'package:acanvas_commons/acanvas_commons.dart'
    show Ac, MLifecycle, FlowOrientation;

import 'package:acanvas_framework/src/core.all.dart' show AbstractAcPlugin;
import 'package:acanvas_template/acanvas_template.dart'
    show AbstractReflowScreen, AbstractScreen, Dimensions, EffectIDs;

part 'src/stagexl_example_plugin.dart';
part 'src/model/stagexl_example_screen_ids.dart';
part 'src/view/screen/bitmapdata_hidpi.dart';
part 'src/view/screen/map_filter.dart';
part 'src/view/screen/sprite3d_example.dart';
part 'src/view/screen/bezier.dart';
part 'src/view/element/bezier/curve.dart';
part 'src/view/element/bezier/curve_data.dart';
part 'src/view/screen/drag.dart';
part 'src/view/screen/logo.dart';
part 'src/view/screen/memory.dart';
part 'src/view/element/memory/card.dart';
part 'src/view/element/memory/game.dart';
part 'src/view/element/memory/playing_field.dart';
part 'package:acanvas_template/examples/stagexl/src/view/element/sprite3d/cube_face.dart';

part 'src/view/screen/stage_xlhome.dart';
// ## SCREEN INSERTION PLACEHOLDER - DO NOT REMOVE ## //

// ## ELEMENT INSERTION PLACEHOLDER - DO NOT REMOVE ## //
