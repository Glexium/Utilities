abstract class SingletonScaleBase {

	double x=1.0, y=1.0;
	double _baseMultiplier=0;
	double aproxResolution;
	bool _isLandScape;

	double get currentX => x;
	double get currentY => y;
	set isLandScape(bool isLandScape) => _isLandScape = isLandScape;
	bool get currentOrientationLandScape =>_isLandScape;
	double get getBaseMultiplier => _baseMultiplier;
	set baseMultiplier(double baseMultiplier) => _baseMultiplier =baseMultiplier;

	void setXY(double currentX, double currentY)
	{
		x=currentX;
		y=currentY;
	}
}