using Common;


class Intersection {
	public var thing:Thing;
	public var ray:Ray;
	public var dist:Float;

	public function new(thing:Thing, ray:Ray, dist:Float){
		this.thing = thing;
		this.ray = ray;
		this.dist = dist;
	}
}