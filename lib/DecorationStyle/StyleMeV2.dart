//Copyright (c) 2021 Miguel Domínguez

//This work is licensed under the terms of the MIT license.
//For a copy, license that can be found in the NOTICES file.
import 'Model/ObjStyle.dart';

/// Types of decoration.
enum DecorationType {
  enabled,
  disabled,
  focused,
  error,
  warning,
  selected,
  empty,
  primary,
  secondary,
  success
}

/// Types of component to decorate.
enum ComponentType { container, textField, cursor, label, hint, icon }

abstract class StyleMeV2 {
  Set<dynamic>? decorations;
  Set<dynamic>? components;
  Set<dynamic>? themes;
  StyleMeV2? _next;

  StyleMeV2({this.themes, this.decorations, this.components});

  //bool get uDecoration => decorations!.containsAll(DecorationType.values);
  //bool get uComponents => components!.containsAll(ComponentType.values);

  set next(StyleMeV2 nextStyle) => _next = nextStyle;

  void addLevel(dynamic level) => decorations!.add(level);
  void addComponent(dynamic cType) => components!.add(cType);

  /// This set a style from [stylesConfiguration]
  ///
  /// This requires a [stylesConfiguration] for example:
  /// Set<ObjStyle> _colorStyle = {
  /// 	ObjStyle(DecorationType.enabled, ComponentType.container, Colors.grey),
  /// 	ObjStyle(DecorationType.enabled, ComponentType.cursor, Colors.grey.withOpacity(0.4)),
  /// 	ObjStyle(DecorationType.enabled, ComponentType.icon, Colors.grey)
  ///
  /// 	ObjStyle(DecorationType.disabled, ComponentType.container, Color(0xFFf4f3f3).withOpacity(0.5)),
  /// 	ObjStyle(DecorationType.disabled, ComponentType.cursor, Color(0xFFf4f3f3).withOpacity(0.4)),
  /// 	ObjStyle(DecorationType.disabled, ComponentType.icon, Color(0xFFf4f3f3)),
  /// }
  ///
  /// Set<ObjStyle> getColorStyle() => _colorStyle;
  ///
  /// Then it will search in the [stylesConfiguration] for [style.getDType] and [style.getCType],
  /// with this it set a value on [setStyle].
  ///
  /// Example:
  ///   var decorator = DecorationSetter(Set.from([DecorationType.enabled]), Set.from([ComponentType.cursor]));
  ///   decorator.checkStyle(getColorStyle());
  ///   return decorator.getStyle();
  ///   This will return: Color(0xFFf4f3f3).withOpacity(0.4)
  ///
  /// Inside a widget with a color property:
  ///   color: loadColorStyle(decorationType, ComponentType.container),
  /// if [decorationType] is changed on the parent widget and it's shared between all
  /// widgets can make all widget change their decoration.
  void checkStyle(Set<ObjStyle> stylesConfiguration) {
    for (ObjStyle style in stylesConfiguration) {
      if (decorations!.contains(style.getDType) &&
          components!.contains(style.getCType)) {
        setStyle(style.getValue);
        break;
      }
    }
    _next?.checkStyle(stylesConfiguration);
  }

  void checkStyleWithTheme(Set<ObjStyle> stylesConfiguration) {
    for (ObjStyle style in stylesConfiguration) {
      if (decorations!.contains(style.getDType) &&
          components!.contains(style.getCType) &&
          themes!.contains(style.getTheme)) {
        setStyle(style.getValue);
        break;
      }
    }
    _next?.checkStyle(stylesConfiguration);
  }

  void setStyle(dynamic style);
}
