package com.kiko.ui
{
	// adobe
	import com.kiko.display.Image;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	//
	// own
	import com.kiko.display.Rect;
	//
	public class IconButton extends Sprite
	{
		// data
		public var toggleOn:Boolean;
		//
		// graphics
		private var ico:Image;
		//
		//
		public function IconButton(imgPath:String, onComplete:Function, centered:Boolean = false ):void
		{
			var bg:Rect;
			
			ico = new Image(imgPath, function() {
				onComplete();
				bg = new Rect(ico.width, ico.height, 0x000000);
				addChild(bg);
				setChildIndex(bg, 0);
				bg.alpha = 0.0;
			}, centered);
			addChild(ico);
			this.addEventListener(MouseEvent.CLICK, function() {
				toggle();
			});
		}
		
		public function toggle():void {
			toggleOn = !toggleOn;
		}
	}//end-class
}//end-pack