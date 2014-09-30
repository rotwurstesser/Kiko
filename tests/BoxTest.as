﻿package tests
{
	// adobe
	import com.kiko.ui.buttons.IconButton;
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
				//createBox();
			}
			var b:Box = createBox();
			
			
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
			
			var l:Image = new Image("resources/swf/cross_icon.swf", new Function());
			addChild(l);
			l.x = 100;
			l.y = 100;
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
			var s:Slider = box.addSlider("Test Slider", 0, 100, 10);
			box.addTextButton("Get Value", 0x83F52E).addEventListener(MouseEvent.CLICK, function() {
				trace( s.value);
			});
			//box.addToggleButton("Test Toggler", 0xff00aa);
			//box.addSlider("Drink Count", 50, 80, 50);
			//box.addToggleButton("Toggle Checkbox", 0xd5ffa5);
			//makeFor(10, function() { box.addTextButton("Notice", 0x4a55ff) } );
			//makeFor(10, function() { box.addSlider("Drink Count", 50, 80, 50) } );
			//box.addTextButton("Notice", 0x4a55ff);
			//box.addTextButton("Alert Button", 0xff3443).width = 50
			//box.addTextButton("Standard Button", 0x656565);
			return box;
		}
		
		private function makeFor(count:uint, func:Function) {
			for (var i:uint = 0; i < count; i++) func();
		}
	}//end-class
}//end-pack
