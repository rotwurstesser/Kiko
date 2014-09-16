package tests
{
	// adobe
	import flash.display.Sprite
	import flash.events.Event;
	//
	// own
	import com.kiko.display.*;
	import com.kiko.text.*;
	//
	public class Model extends Sprite
	{
		//
		//
		//
		public function Model():void {
			addEventListener(Event.ADDED_TO_STAGE, toStage);
		}
		
		private function toStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, toStage);
			trace("test inited");
			create();
		}
		
		private function create():void {
		}
	}//end-class
}//end-pack
