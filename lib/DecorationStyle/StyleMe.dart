import 'Model/ObjStyle.dart';

enum DecorationType { enabled, disabled, focused, error, warning, selected, empty, primary, secondary, success}
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

	void checkStyle(Set<ObjStyle> styles)
	{
		for(ObjStyle style in styles)
		{
			if(decorations.contains(style.getDType) && components.contains(style.getCType))
			{
				setStyle(style.getValue);
				break;
			}
		}
		_next?.checkStyle(styles);
	}

	void setStyle(dynamic style);
}