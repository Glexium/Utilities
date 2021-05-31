import '../StyleMe.dart';

class ObjStyle
{
	DecorationType? _dType;
	ComponentType? _cType;
	dynamic _value;

	ObjStyle(DecorationType dType, ComponentType cType, dynamic value)
	{
		this._dType	= dType;
		this._cType = cType;
		this._value = value;
	}

	get getDType => _dType;
	get getCType => _cType;
	get getValue => _value;
}