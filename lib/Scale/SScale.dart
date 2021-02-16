import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:universal_io/prefer_universal/io.dart';

import 'SScaleBase.dart';

class SScale extends SingletonScaleBase {
	static final SScale _instance = SScale._internal();
	double get _ppi => (Platform.isAndroid || Platform.isIOS)? 120 : 96;

	factory SScale() {
		return _instance;
	}

	SScale._internal()
	{
		x = 480;
		y = 640;
	}

	void init(BuildContext mContext)
	{
		MediaQueryData _mediaQueryData = MediaQuery.of(mContext);
		isLandScape = _mediaQueryData.orientation == Orientation.landscape;
		if(currentOrientationLandScape)
		{
			setXY(_mediaQueryData.size.height, _mediaQueryData.size.width);
		}
		else
		{
			setXY(_mediaQueryData.size.width, _mediaQueryData.size.height);
		}
		double _screenHeightPx = _mediaQueryData.size.longestSide * _mediaQueryData.devicePixelRatio;
		double _screenWidthPx = _mediaQueryData.size.shortestSide * _mediaQueryData.devicePixelRatio;
		double _diagonal = sqrt(pow(_screenWidthPx, 2)+pow(_screenHeightPx, 2));
		double _safeAreaVertical = _mediaQueryData.padding.top*1.5 + _mediaQueryData.padding.bottom*1.5;
		aproxResolution = (_diagonal-_safeAreaVertical)/(_ppi*_mediaQueryData.devicePixelRatio);
	}

	double getIdealTextSize(int base)
	{
		if(Platform.isAndroid)
			base--;
		if(getBaseMultiplier<=0)
		{
			baseMultiplier = (double.parse((aproxResolution).toStringAsFixed(4)))/5.4079;
		}
		return getBaseMultiplier*base;
	}

	get getIconSize => currentOrientationLandScape?currentX * 0.08: currentX * 0.05;
	get getBigIconSize => currentOrientationLandScape?currentX * 0.11: currentX * 0.08;
	get getIconSizeSmall => currentX *0.06;
	get getEtHeight => currentY * 0.05;
	get getBtnHeight => currentY * 0.05;
	get getX => currentX;
	get getY => currentY;
	get getTitleLogoTextSize => 18;
	get getBtnBaseTextSize => 12;
	get getTVBaseTextSize => 12;
	get getETBaseTextSize => 13;
	get getSubTitleTextSize => 14;
}