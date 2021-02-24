import 'StyleMe.dart';

/// This class is for set decorations on a widget depending on a configuration file.
///
/// It use dependency chain pattern.
class DecorationSetter extends StyleMe
{
	dynamic _style;
	/// This sets the Decoration type and component type to decorate.
	///
	/// Example:
	/// DecorationSetter(Set.from([DecorationType.enabled]), Set.from([ComponentType.textField]));
	DecorationSetter(Set<DecorationType> levels, Set<ComponentType> cTypes) : super(decorations: levels, components: cTypes);

  void setStyle(dynamic style) => _style = style;
  dynamic getStyle()=> _style;

}