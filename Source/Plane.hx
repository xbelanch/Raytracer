using Common;

class Plane implements Thing {

	var norm:Vector;
	var offset:Float;
	public var surface:Surface;

	// constructor
	public function new(norm: Vector, offset, surface:Surface){
		this.surface = surface;
		this.norm = norm; 
		this.offset = offset;
	}

	public function normal(pos:Vector){
		return norm;
	}; 
	
	public function intersect(ray:Ray):Intersection{
		var denom = Vector.dot(norm, ray.dir);
		if (denom > 0)
			return null;
		else {
			var dist = (Vector.dot(norm, ray.start) + offset) / (-denom);
			return new Intersection(this, ray, dist);
		}
	}
}