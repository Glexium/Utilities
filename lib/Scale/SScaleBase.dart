import 'package:utilities/Scale/SScale.dart';

/// Abstract class for [SScale]
abstract class SingletonScaleBase {

	double x=1.0, y=1.0;
	double _baseMultiplier=0;
	double approxResolution=1.0;
	bool _isLandScape=false;

	double get currentX => x;
	double get currentY => y;
	set isLandScape(bool isLandScape) => _isLandScape = isLandScape;
	bool get currentOrientationLandScape =>_isLandScape;
	double get getBaseMultiplier => _baseMultiplier;
	set baseMultiplier(double baseMultiplier) => _baseMultiplier =baseMultiplier;

	/// Initialize screen's [x] and [y] values.
	void setXY(double currentX, double currentY)
	{
		x=currentX;
		y=currentY;
	}
}