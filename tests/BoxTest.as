package tests
{
	// adobe
	import com.kiko.ui.buttons.IconButton;
	import com.kiko.ui.buttons.ToggleButton;
	import com.kiko.ui.Slider;
	import flash.display.Sprite
	import flash.events.Event;
	import flash.events.MouseEvent;
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
		
		private function toStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, toStage);
			trace("test inited");
			
			for (var i:uint = 0; i < 10; i++) {
				/*var a:Box = createBox();
				a.active = true;
				a.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {
					(e.currentTarget as Box).active = true;
				});*/
			}
			var b:Box = createBox();
			//b.active = true;
			
			
			addEventListener(Event.ENTER_FRAME, function() {
				//b.height -= 1;
			});
			
			multiImage();
			
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
			box.y = Math.random()* 500;
			//box.y = 100;
			box.title = "MyBox";
			box.height = 250;
			box.width = 350;
			box.addToggleButton("Super Toggler");
			box.addToggleButton("Super Toggler");
			box.addToggleButton("Super Toggler");
			box.addToggleButton("Super Toggler");
			var n:ToggleButton = box.addToggleButton("Super Toggler");
			
			box.addToggleButton("New Tester Toggler").addEventListener(MouseEvent.CLICK, function() {
				trace(n.toggleOn);
			});
			/*
			var s:Slider = box.addSlider("New", 10, 20, 14, false);
			box.addSlider("Test Slider", 10, 20, 7);
			box.addSlider("Test Slider", 10, 20, 12);
			box.addTextButton("Get Value", 0x83F52E).addEventListener(MouseEvent.CLICK, function() {
				trace( s.value);
			});
			box.addToggleButton("Test Toggler", 0xff00aa);
			box.addToggleButton("Toggle Checkbox", 0xd5ffa5);
			box.addTextButton("Notice", 0x4a55ff);
			box.addTextButton("Alert Button", 0xff3443).width = 50
			box.addTextButton("Standard Button", 0x656565);
			*/
			return box;
		}
		
		private function makeFor(count:uint, func:Function) {
			for (var i:uint = 0; i < count; i++) func();
		}
	}//end-class
}//end-pack
