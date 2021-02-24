import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:universal_io/prefer_universal/io.dart';

import 'SScaleBase.dart';

/// Singleton to scale screen components.
class SScale extends SingletonScaleBase {

	// It creates default values to avoid crashes.
	static final SScale _instance = SScale._internal();
	// It sets default 'points per inch' depending on the platform
	double get _ppi => (Platform.isAndroid || Platform.isIOS)? 120 : 96;

	/// Returns an instance of [SScale]
	factory SScale() {
		return _instance;
	}

	/// It sets default [x] and [y] values
	SScale._internal()
	{
		x = 480;
		y = 640;
	}

	/// Initialize [SScale] using [mContext]
	///
	/// This section calculates an approximately screen's resolution and set width and height.
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
		// It can be more exact, but requires dpi of the device and mediaQueryData doesn't return it
		approxResolution = (_diagonal-_safeAreaVertical)/(_ppi*_mediaQueryData.devicePixelRatio);
	}

	/// Returns a calculated text size depending on the screen resolution.
	/// 
	/// It calculate the [baseMultiplier] once and then returns a multiplied [baseSize]
	double getIdealTextSize(int baseSize)
	{
		if(Platform.isAndroid)
			baseSize--;
		if(getBaseMultiplier<=0)
		{
			// The value 5.4079 is a screen size I used as a base to calculate text sizes.
			baseMultiplier = (double.parse((approxResolution).toStringAsFixed(4)))/5.4079;
		}
		return getBaseMultiplier*baseSize;
	}

	// Default values
	//ToDo Note to myself parametrized all values and add observer for current orientation
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