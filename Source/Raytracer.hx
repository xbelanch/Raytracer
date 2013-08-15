using Common;


class Raytracer {

	var maxDepth = 5;

	var root: Common.SPRITE;
	var bitmap : Common.BITMAP;
	var output : Common.BITMAPDATA;
    var wScreen : Int;
    var hScreen: Int;


	var scene:Scene;

	// constructor 
	public function new(root){
		this.root = root;
        wScreen =  flash.Lib.current.stage.stageWidth;
        hScreen =  flash.Lib.current.stage.stageHeight;

		output = new Common.BITMAPDATA(wScreen, hScreen, false, 0xccff0000 );
        bitmap = new Common.BITMAP(output);
        root.addChild(bitmap);

        trace("Raytracer v0.0.1");
		init();
	}

	
	function init(){
		defaultScene();
        render(scene, wScreen, hScreen);
	}


    function intersections(ray: Ray, scene: Scene) {
        var closest = Const.BIG;
        var closestInter: Intersection = null;
        for (thing in scene.things) {
            var inter = thing.intersect(ray);
            if (inter != null && inter.dist < closest) {
                closestInter = inter;
                closest = inter.dist;
            }
        }
        return closestInter;
    }

    function testRay(ray:Ray, scene:Scene){
    	var isect = this.intersections(ray, scene);
    	if (isect != null)
    		return isect.dist;
    	else 
    		return -1; // undefinided?
    }



    function traceRay(ray: Ray, scene: Scene, depth:Int){
    	var isect = intersections(ray, scene);
    	if (isect == null) // undefined
    		return Color.background;
    	else
    		return this.shade(isect, scene, depth);
    }

    function shade(isect:Intersection, scene: Scene, depth:Int){
    	var d = isect.ray.dir;
    	var pos = Vector.plus(Vector.times(isect.dist, d), isect.ray.start);
    	var normal = isect.thing.normal(pos);
    	var reflectDir = Vector.minus(d, Vector.times(2, Vector.times(Vector.dot(normal, d), normal)));
    	var naturalColor = Color.plus(Color.background, this.getNaturalColor(isect.thing, pos, normal, reflectDir, scene));
       var reflectedColor = (depth >= this.maxDepth) ? Color.grey : this.getReflectionColor(isect.thing, pos, normal, reflectDir, scene, depth);
       return Color.plus(naturalColor, reflectedColor);
    }

    private function getReflectionColor(thing:Thing, pos:Vector, normal: Vector, rd:Vector, scene: Scene, depth: Int)
    {
    	return Color.scale(thing.surface.reflect(pos), this.traceRay(new Ray(pos, rd), scene, depth + 1));
    }


    function getNaturalColor(thing: Thing, pos: Vector, norm:Vector, rd: Vector, scene:Scene){

    	var addLight = function(light, col){
    		var ldis = Vector.minus(light.pos, pos);
    		var livec = Vector.norm(ldis);
    		var neatIsect = this.testRay(new Ray(pos, livec), scene);
    		var isInShadow = (neatIsect == -1) ? false : (neatIsect <= Vector.mag(ldis));
    		
    		if (isInShadow){
    			return col;
    		} else {
    			var illum = Vector.dot(livec, norm);
    			var lcolor = (illum > 0) ? Color.scale(illum, light.color) : Color.defaultColor;
    			var specular = Vector.dot(livec, Vector.norm(rd));
    			var scolor = (specular > 0) ? Color.scale(Math.pow(specular, thing.surface.roughness), light.color) : Color.defaultColor;
    			return Color.plus(col, Color.plus(Color.times(thing.surface.diffuse(pos), lcolor), Color.times(thing.surface.specular(pos), scolor)));
    		}
    	}

    	// http://haxe.org/doc/cross/lambda
    	// array.reduce
    	return Lambda.fold(scene.lights, addLight, Color.defaultColor);

    	// return scene.lights.red
    }


    function render(scene:Scene, screenWidth:Int, screenHeight:Int){
    	// render the scene
    	output.fillRect(output.rect, 0);
		output.lock();
    	for (y in 0... screenHeight ){
    		for (x in 0 ... screenWidth ){
    			var recenterX = (x - (screenWidth / 2.0)) / 2.0 / screenWidth;
    			var recenterY = -(y - (screenHeight / 2.0)) / 2.0 / screenHeight;
    			var getPoint = 
    			Vector.norm(
    					Vector.plus(
    						scene.camera.forward, Vector.plus(
    							Vector.times(
    								recenterX, scene.camera.right
    							), Vector.times(
    								recenterY, scene.camera.up
    								)
    							)
    						)
    					);
    			var rgb = traceRay(new Ray(scene.camera.pos, getPoint), scene, 0);
    			var c = Color.toDrawingColor(rgb);
                var color = 255 << 32 | c.r << 16 | c.g << 8 | c.b;
    			// draw to the bitmapdata
  				output.setPixel32(x, y, color);
    		}
    	}
    	output.unlock();
    }

	function defaultScene(){
		scene = new Scene();
		scene.things = [
            new Plane(new Vector(0.0, 1.0, 0.0), 0.0, new Surfaces.Checkerboard()),
			new Sphere(new Vector(0.0, 1.0, -0.25), 1.0, new Surfaces.Shiny()),
			new Sphere(new Vector(-1.0, 0.5, 1.5), 0.5, new Surfaces.Shiny())
		];
		scene.lights = [
            new Light(new Vector(1.5, 4.5, 1.5), new Color(0.07, 0.07, 0.49)),
            new Light(new Vector(1.5, 4.5, -1.5), new Color(0.07, 0.49, 0.071)) ,
            new Light (new Vector(0.0, 4.5, 0.0), new Color(0.21, 0.21, 0.35)),
			new Light(new Vector(-2.0, 4.5, 0.0), new Color(0.45, .07, 0.07))
		];
		scene.camera = new Camera(new Vector(3.0, 2.0, 4.0), new Vector(-1.0, 0.5, 0.0));
	}


}