using Common;

class Camera {

	public var pos:Vector;
	public var forward:Vector;
	public var right:Vector;
	public var up:Vector;

	// constructor
	public function new(pos, lookAt){

		this.pos = pos;
		var down = new Vector(0.0, -1.0, 0.0);
		this.forward = Vector.norm(Vector.minus(lookAt, this.pos));
		this.right = Vector.times(1.5, Vector.norm(Vector.cross(this.forward, down)));
		this.up = Vector.times(1.5, Vector.norm(Vector.cross(this.forward, this.right)));
	}
}