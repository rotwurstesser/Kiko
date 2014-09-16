package tests
{
	// adobe
	import flash.display.Sprite
	import flash.events.Event;
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
			createBox();
		}
		
		
		
		private function createBox():void {
			
			for (var i:uint = 0; i < 10; i++) {
				var box:Box = new Box();
				addChild(box);
				box.x = Math.random()* 500;
				box.y = Math.random()* 500;
				//box.y = 100;
			}
			
			
		}
	}//end-class
}//end-pack
