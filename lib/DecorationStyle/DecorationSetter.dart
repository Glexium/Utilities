import 'StyleMe.dart';

class DecorationSetter extends StyleMe
{
	dynamic _style;
	DecorationSetter(Set<DecorationType> levels, Set<ComponentType> cTypes) : super(decorations: levels, components: cTypes);

  void setStyle(dynamic style) => _style = style;
  dynamic getStyle()=> _style;

}