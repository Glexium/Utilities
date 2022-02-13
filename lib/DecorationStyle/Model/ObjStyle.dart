class ObjStyle
{
	dynamic _dType;
	dynamic _cType;
	dynamic _theme;
	dynamic _value;

	ObjStyle(dynamic dType, dynamic cType, dynamic value, {dynamic theme})
	{
		this._dType	= dType;
		this._cType = cType;
		this._value = value;
		this._theme = theme;
	}

	get getDType => _dType;
	get getCType => _cType;
	get getTheme => _theme;
	get getValue => _value;
}