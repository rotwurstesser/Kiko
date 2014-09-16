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
		// done
		private function createRectTest():void {
			var rect:Rect = new Rect(100, 100, 0xff00aa);
			addChild(rect);
			rect.x = 200;
			rect.y = 200;
			trace("");
		}
		// todo
		private function createCustomTextfield():void{
			var tf:CustomTextField = new CustomTextField();
			addChild(tf);
			tf.text = "test text";
			tf.appendText("more text");
		}
		// todo
		private function createToggleButtonTest():void{
			var tb:ToggleButton = new ToggleButton("Name");
			addChild(tb);
			// functions
			tb.toggle();
			tb.toggleOn();
			tb.toggleOff();
			// events
			tb.addEventListener(MouseEvent.TOGGLE_OFF, onToggleOf);
			tb.addEventListener(MouseEvent.TOGGLE_ON, onToggleOn);
			// gettters setters
			tb.text = "New Name";
			tb.width = 100;
			tb.height = 50;
			if(tb.on){}
			if(tb.off){}
		}
		// todo
		private static function Math2():void{
			function radToDeg(rad:Number):Number{
				return rad*180/Math.PI;
			}
			function degToRad(deg:Number):Number{
				return deg/180*Math.PI;
			}
			function random(min:Number = 0, max:Number = 1):Number{
				return Math.random()*(min + max) -max;
			}
		}
		// todo
		private function keyboardKeys() {
			
		}
		// todo
		private function selfRemovingEventListeners() {
			
		}
		
	
		
	}//end-class
}//end-pack
