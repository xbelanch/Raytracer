using Common;

class Scene {
    public var things: Array<Thing>;
    public var lights: Array<Light>;
    public var camera: Camera;

    public function new(){
    	things = new Array<Thing>();
    	lights = new Array<Light>(); 	
    }
}