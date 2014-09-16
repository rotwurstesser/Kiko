package tests
{
	// adobe
	import com.kiko.ui.ScrollElement;
	import flash.display.Sprite
	import flash.events.Event;
	//
	// own
	import com.kiko.display.*;
	import com.kiko.text.*;
	//
	public class ScrollbarTest extends Sprite
	{
		//
		//
		//
		public function ScrollbarTest():void {
			addEventListener(Event.ADDED_TO_STAGE, toStage);
		}
		
		private function toStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, toStage);
			trace("scrollbar test inited");
			createScrollbar();
		}
		
		private function createScrollbar():void {
			var bar:ScrollElement = new ScrollElement(stage, 0xff00aa, 0xaaff00);
			addChild(bar);
			bar.x = 200;
			bar.y = 200;
		}
		// done

		
	
		
	}//end-class
}//end-pack
