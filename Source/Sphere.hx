using Common;

class Sphere implements Thing {

	public var radius2: Float;
	public var center: Vector;
	public var surface:Surface;

	// constructor
	public function new(center:Vector, radius:Float, surface:Surface){
		this.center = center;
		this.radius2 = radius * radius;
		this.surface = surface;
	}

	public function normal(pos:Vector):Vector {
		return Vector.norm(Vector.minus(pos, center));
	}

	public function intersect(ray:Ray):Intersection{

        // Spehere code from the Book "Raytracing from the ground up"
		var t = 0.0;
		var tmin = 0.0;
		var temp = Vector.minus(ray.start, center);
		var a = Vector.dot(ray.dir, ray.dir);
		var b = 2.0 * Vector.dot(temp, ray.dir);
		var c = Vector.dot(temp, temp) - radius2;
		var disc = b * b - 4.0 * a * c;

		if (disc <0.0)
			return null;
		else {
			var e = Math.sqrt(disc);
			var denom = 2.0 * a;
			t = ( - b - e) / denom; // smaller root

			if (t > Const.EPSILON){
				tmin = t;
				return new Intersection(this, ray, tmin);
			}

			t = ( -b + e) / denom; // larger root

			if (t > Const.EPSILON){
				tmin = t;
				return new Intersection(this, ray, tmin);
			}
		}
		return null;
	}
}


