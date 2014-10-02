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
		
		private function toStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, toStage);
			trace("test inited");
			
			for (var i:uint = 0; i < 2; i++) {
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
				//colorCircle();
			}
			var b:Box = createBox();
			//b.active = true;
			
			
			addEventListener(Event.ENTER_FRAME, function() {
				//b.height -= 1;
			});
			
			multiImage();
			
			
			
			
		}
		
		private function colorCircle():void 
		{
			var c:Sprite = new Sprite();
			c.graphics.lineStyle(2, Math.random()*0xffffff);
			c.graphics.beginFill(0xffffff);
			c.graphics.drawCircle(0, 0, 7);
			addChild(c);
			c.x = Math.random() *500;
			c.y = Math.random() *500;
			c.filters = [new DropShadowFilter(0, 0, 0, 0.15, 10, 10, 1, 3)];
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
			box.color = 0xff3443;
			//box.y = 100;
			box.title = "MyBox";
			//box.height = 250;
			//box.width = 350;
			//box.addToggleButton("Super Toggler");
			//var n:ToggleButton = box.addToggleButton("Super Toggler");
			//box.addStepper("Test Stepper: 100", 10, 100, 20, 1);
			//box.addStepper("Super Test: 24", 0, 5, 2, 1);
			//box.addTextButton("Text Button Size");
			
			makeFor( 1, function(){ box.addStepper("Test Stepper", 10, 100, 20, 1); });
			
			makeFor( 0, function() {
				var r = Math.random() * 0xffffff;
				var b = 0x4a55ff;
				var a = 0xff3443;
				box.addTextButton("Super Color", a).addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {
					trace( (e.currentTarget as TextButton).borderColor );
				} );
			} );
			
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
