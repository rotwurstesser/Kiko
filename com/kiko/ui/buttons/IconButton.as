package com.kiko.ui.buttons
{
	/**
	 * Version 1.03
	 */
	// adobe
	import com.kiko.display.Image;
	import flash.display.DisplayObject;
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
		/**
		 * @param	imgPath Pfad zum Icon (.swf, .jpg, .png ...)
		 * @param	onComplete Funktion wenn fertig geladen.
		 * @param	overlay Ein Objekt das über das Icon gelegt wird. Meistens ist es durchsichtig.
		 * @param	centerIcon Einmitten des Icons im overlay.
		 */
		public function IconButton(imgPath:String, onComplete:Function, overlay:DisplayObject = null, centerIcon:Boolean = false ):void {
			var bg:Rect;
			ico = new Image(imgPath, function() {
				if (overlay) {
					addChild(overlay);
					if (centerIcon) {
						ico.x = overlay.width / 2 - ico.width/2;
						ico.y = overlay.height / 2 - ico.height / 2;
					}
					overlay.alpha = 0.0;
				}
				else {
					bg = new Rect(ico.width, ico.height, 0x000000);
					addChild(bg);
					setChildIndex(bg, 0);
					bg.alpha = 0.1;
				}
				onComplete();
			}, false);
			addChild(ico);
		}
	}//end-class
}//end-pack