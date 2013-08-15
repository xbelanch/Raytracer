// Common.hx
// Common header for classes


typedef SPRITE = flash.display.Sprite;
typedef BITMAPDATA = flash.display.BitmapData;
typedef BITMAP = flash.display.Bitmap;

@:publicFields class Const {

	static inline var BIG = 1e10;
	static inline var EPSILON = 1e-03;
}


interface Surface {
    function diffuse(pos: Vector): Color;
    function specular (pos: Vector): Color;
    function reflect (pos: Vector):  Float;
    var roughness: Int;
}

interface Thing {
    function intersect(ray: Ray): Intersection;
    function normal(pos: Vector): Vector;
    var surface: Surface;
}

