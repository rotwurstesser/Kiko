package tests
{
	// adobe
	import com.kiko.ui.buttons.IconButton;
	import com.kiko.ui.buttons.TextButton;
	import com.kiko.ui.buttons.TextButton;
	import com.kiko.ui.buttons.ToggleButton;
	import com.kiko.ui.Slider;
	import flash.display.Sprite
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	//
	// own
	import com.kiko.display.*;
	import com.kiko.text.*;
	import com.kiko.ui.Box;
	//
	public class BoxTest extends Sprite
	{
		//
		//
		//
		public function BoxTest():void {
			addEventListener(Event.ADDED_TO_STAGE, toStage);
		}
		
		private function toStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, toStage);
			var numBoxes:uint = 5;
			for (var i:uint = 0; i < numBoxes; i++) {
				var a:Box = createBox();
				a.active = false;
				a.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent) {
					for (var j:uint = 0; j < numChildren; j++) {
						if ( getChildAt(j) is Box ) {
							(getChildAt(j) as Box).active = false;
						}
					}
					(e.currentTarget as Box).active = true;
				});
			}
		}
		
		private function multiImage():void 
		{
			//var m:MultiImage = new MultiImage();
			//m.loadImage( new IconButton("resources/swf/cross_icon.swf",
			//addChild(m);
		}

		private function createBox():Box {
			
			var box:Box = new Box();
			addChild(box);
			box.x = Math.random()* 500;
			box.y = Math.random() * 500;
			box.color = Math.random() * 0xffffff;
			//box.y = 100;
			box.title = "MyBox";
			//box.height = 250;
			//box.width = 350;
			//box.addToggleButton("Super Toggler");
			//var n:ToggleButton = box.addToggleButton("Super Toggler");
			//box.addStepper("Test Stepper: 100", 10, 100, 20, 1);
			//box.addStepper("Super Test: 24", 0, 5, 2, 1);
			//box.addTextButton("Text Button Size");
			
			/**
			 * TextButtons mit mehrerern Farben.
			 */
			if( 1 ){
			box.addTextButton("Standard");
			box.addTextButton("Change Color", 0x4BCA00).addEventListener(MouseEvent.CLICK, function() {
				box.color = Math.random() * 0xffffff;
			});
			box.addTextButton("Alert", 0xEE4A04);
			box.addTextButton("Orange", 0xE4890E);
			box.addTextButton("Pink", 0xDD1574);
			box.addTextButton("Skyblue", 0x019DF1);
			box.addTextButton("Blue", 0x0A5EE9);
			}
			
			/**
			 * Stepper, Slider, ToggleButton und TextButton.
			 */
			if( 0 ) {
			makeFor( 5, function() { 
			box.addStepper("Stepper Test", -5000, 580, Math.random()*(-5000, 580) -5000, 31);
			box.addSlider("Apples", -500, 500, -100);
			box.addToggleButton("Yes");
			box.addTextButton("Super");
			});
			}
			
			/**
			 * Mehrere TextButtons
			 */
			if( 0 ){
				makeFor( 20, function() {
					var r = Math.random() * 0xffffff;
					var b = 0x4a55ff;
					var a = 0xff3443;
					box.addTextButton("Super Color", b	).addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {
						trace( (e.currentTarget as TextButton).borderColor );
					} );
				} );
			}
			
			/**
			 * Verschiedene Optionen: width, height, minVal, maxVal
			 */
			if( 0 ) {
			var s:Slider = box.addSlider("New", 10, 20, 14, false);
			box.addSlider("Test Slider", 10, 20, 7);
			box.addSlider("Test Slider", -100, 500, -50);
			box.addTextButton("Get Value", 0x83F52E).addEventListener(MouseEvent.CLICK, function() {
				trace( s.value);
			});
			box.addToggleButton("Test Toggler");
			box.addToggleButton("Toggle Checkbox");
			box.addTextButton("Notice", 0x4a55ff);
			box.addTextButton("Alert Button", 0xff3443).width = 50
			box.addTextButton("Standard Button", 0x656565).height = 40;
			}
			
			if ( 0 ) {
				box.addStepper("Stepper", -9999, 99999, 100, 58);
			}
			
			return box;
		}
		
		private function makeFor(count:uint, func:Function) {
			for (var i:uint = 0; i < count; i++) func();
		}
	}//end-class
}//end-pack
