import 'Model/ObjStyle.dart';

/// Types of decoration.
enum DecorationType { enabled, disabled, focused, error, warning, selected, empty, primary, secondary, success}
/// Types of component to decorate.
enum ComponentType { container, textField, cursor, label, hint, icon}

abstract class StyleMe {
	Set<DecorationType> decorations;
	Set<ComponentType> components;
	StyleMe _next;

	StyleMe({this.decorations, this.components});

	bool get uDecoration => decorations.containsAll(DecorationType.values);
	bool get uComponents => components.containsAll(ComponentType.values);

	set next(StyleMe nextStyle) => _next = nextStyle;

	void addLevel(DecorationType level) => decorations.add(level);
	void addComponent(ComponentType cType) => components.add(cType);

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
	void checkStyle(Set<ObjStyle> stylesConfiguration)
	{
		for(ObjStyle style in stylesConfiguration)
		{
			if(decorations.contains(style.getDType) && components.contains(style.getCType))
			{
				setStyle(style.getValue);
				break;
			}
		}
		_next?.checkStyle(stylesConfiguration);
	}

	void setStyle(dynamic style);
}