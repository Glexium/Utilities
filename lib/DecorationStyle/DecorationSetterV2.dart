//Copyright (c) 2021 Miguel Domínguez

//This work is licensed under the terms of the MIT license.
//For a copy, license that can be found in the NOTICES file.
import 'StyleMeV2.dart';

/// This class is for set decorations on a widget depending on a configuration file.
///
/// It use dependency chain pattern.
class DecorationSetterV2 extends StyleMeV2 {
  dynamic _style;

  /// This sets the Decoration type and component type to decorate.
  ///
  /// Example:
  /// DecorationSetter(Set.from([DecorationType.enabled]), Set.from([ComponentType.textField]));
  DecorationSetterV2(
      Set<dynamic> themes, Set<dynamic> levels, Set<dynamic> cTypes)
      : super(themes: themes, decorations: levels, components: cTypes);

  void setStyle(dynamic style) => _style = style;
  dynamic getStyle() => _style;
}
