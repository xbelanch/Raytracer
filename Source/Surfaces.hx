using Common;


class Shiny implements Surface {
	public function new(){};
	public function diffuse(pos) {return Color.white; };
	public function specular(pos) {return Color.grey; };
	public function reflect(pos){return 0.7; };
	public var roughness = 250;
}

class Checkerboard implements Surface {
	public function new(){};
	public function diffuse(pos){
		if ((Math.floor(pos.z) +  Math.floor(pos.x)) % 2 != 0){
			return Color.white;
		} else {
			return Color.black;
		}
	};
	public function specular(pos ){return Color.white;};
	public function reflect(pos){
		if((Math.floor(pos.z) + Math.floor(pos.x)) % 2 != 0){
			return 0.1;
		} else {
			return 0.7;
		}
	};
	public var roughness =  150;
}
