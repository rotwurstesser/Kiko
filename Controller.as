package
{
	// adobe
	import flash.display.Sprite
	//
	// own
	import com.kiko.display.*;
	import com.kiko.text.*;
	//
	public class Controller extends Sprite
	{
		//
		//
		//
		public function Controller():void{
			createRectTest();
			createToggleButtonTest();
		}
		
		private function createRectTest():void {
			var rect:Rect = new Rect(100, 100, 0xff00aa);
			addChild(rect);
			rect.x = 200;
			rect.y = 200;
			trace("");
		}
		
		private function createTextField():void{
			var tf:CustomTextField = new CustomTextField();
			addChild(tf);
			tf.text = "test text";
			tf.appendText("more text");
		}
		private function createToggleButtonTest():void{
			var tb:ToggleButton = new ToggleButton("Name");
			addChild(tb);
			
		}
	}//end-class
}//end-pack
