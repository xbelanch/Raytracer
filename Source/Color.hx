using Common;

class Color {

	public var r:Float;
	public var g:Float;
	public var b:Float;

	// a few colors
	public static var white = new Color(1.0, 1.0, 1.0);
	public static var grey = new Color(.5, .5, 5);
	public static var black = new Color(0, 0, 0);
	public static var background = Color.black;
	public static var defaultColor  = Color.black;

	// constructor
	public function new(r, g, b){
		this.r = r;
		this.g = g;
		this.b = b;
	}

	public static inline function scale(k:Float, v:Color){
		return new Color(
			k * v.r,
			k * v.g,
			k * v.b
		);
	}

	public static inline function plus(v1: Color, v2:Color){
		return new Color(
			v1.r + v2.r,
			v1.g + v2.g,
			v1.b + v2.b
		);
	}

	public static inline function times(v1: Color, v2:Color){
		return new Color(
			v1.r * v2.r,
			v1.g * v2.g,
			v1.b * v2.b
		);
	}

	public static function toDrawingColor(c:Color){
		return {
			r: Math.floor(legalize(c.r) * 255),
			g: Math.floor(legalize(c.g) * 255),
			b: Math.floor(legalize(c.b) * 255)
		}

	}

	static inline function legalize(d:Float){
		return d > 1 ? 1 : d;
	}

}