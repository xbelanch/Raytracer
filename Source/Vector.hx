using Common;

class Vector {

	public var x: Float;
	public var y: Float;
	public var z: Float;

	// constructor
	public function new(x, y, z){
		this.x = x;
		this.y = y;
		this.z = z;
	}

	public inline static function times(k:Float, v:Vector) {
		return new Vector(
			k * v.x,
			k * v.y,
			k * v.z
		);
	}
	
	public inline static function minus(v1: Vector, v2: Vector){
		return new Vector(
			v1.x - v2.x,
			v1.y - v2.y,
			v1.z - v2.z
		);
	}

	public inline static function plus(v1: Vector, v2:Vector){
		return new Vector(
			v1.x + v2.x,
			v1.y + v2.y,
			v1.z + v2.z
		);
	}


	public inline static function dot(v1: Vector, v2:Vector){
		return v1.x * v2.x + v1.y * v2.y + v1.z * v2.z;
	}

	public inline static function mag(v:Vector){
		return Math.sqrt(v.x * v.x + v.y * v.y + v.z * v.z);
	}

	public inline static function norm(v:Vector){
		var mag = Vector.mag(v);
		var div = (mag == 0) ? Const.EPSILON : 1.0/mag;
		return Vector.times(div, v);
	}

	public inline static function cross (v1:Vector, v2:Vector){
		return new Vector(
			v1.y * v2.z - v1.z * v2.y,
			v1.z * v2.x - v1.x * v2.z,
			v1.x * v2.y - v1.y * v2.x
		);
	}
}


