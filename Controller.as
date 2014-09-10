package
{
	// adobe
	import flash.display.Sprite
	//
	// own
	import com.kiko.display.Rect;
	//
	public class Controller extends Sprite
	{
		//
		//
		//
		public function Controller():void{
			createRectTest();
		}
		
		private function createRectTest():void {
			var rect:Rect = new Rect(100, 100, 0xff00aa);
			addChild(rect);
			rect.x = 200;
			rect.y = 200;
		}
	}//end-class
}//end-pack