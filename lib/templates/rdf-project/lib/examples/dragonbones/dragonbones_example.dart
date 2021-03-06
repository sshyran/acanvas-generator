library dragonbones_example;

import 'dart:async';

import 'package:stagexl/stagexl.dart';
import 'package:stagexl_dragonbones/stagexl_dragonbones.dart';
import 'package:acanvas_commons/acanvas_commons.dart'
    show
        MdText,
        ImageSprite,
        Ac,
        MdWrap,
        AlignH,
        MLifecycle,
        Wrap,
        ScrollOrientation;
import 'package:acanvas_framework/src/core.all.dart'
    show AbstractAcPlugin, AcanvasBoxSprite;
import 'package:acanvas_template/acanvas_template.dart'
    show AbstractScreen, Dimensions, EffectIDs, Theme;

part 'src/dragonbones_example_plugin.dart';
part 'src/model/dragonbones_assets.dart';
part 'src/model/dragonbones_example_screen_ids.dart';
part 'src/view/screen/dragonbones_demon.dart';
part 'src/view/screen/dragonbones_dragon_new.dart';
part 'src/view/screen/dragonbones_swords_man.dart';
part 'src/view/screen/dragonbones_ubbie.dart';
part 'src/view/screen/dragonbones_home.dart';

// ## SCREEN INSERTION PLACEHOLDER - DO NOT REMOVE ## //
part 'src/view/element/home_banner.dart';
part 'src/view/element/home_section1.dart';
part 'src/view/element/home_more_box.dart';
// ## ELEMENT INSERTION PLACEHOLDER - DO NOT REMOVE ## //
