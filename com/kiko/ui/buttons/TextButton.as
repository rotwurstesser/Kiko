package com.kiko.ui.buttons
{
	/**
	 * Version 1.02
	 */
	// adobe
	import com.kiko.display.Image;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	//
	// own
	import com.kiko.display.Rect;
	//
	public class TextButton extends Sprite
	{
		// data
		var btnwidth:Number;
		var btnheight:Number;
		//
		// graphics
		private var bg:Sprite;
		//
		//
		public function TextButton(text:String, width:Number, height:Number = 25, textColor:uint = 0x656565, borderColor:uint = 0xcccccc, hoverColor:uint = 0x656565):void
		{
			this.btnwidth = width;
			this.btnheight = height;
			
			bg = new Sprite();
			bg.graphics.lineStyle(1, borderColor);
			bg.graphics.beginFill(0xffffff);
			drawBg();
			addChild(bg);
			
			var format:TextFormat = new TextFormat("Arial", 12, textColor);
			var tf:TextField = new TextField();
			tf.text = text;
			addChild(tf);
			tf.setTextFormat(format);
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.x = 10;
			tf.selectable = false;
			tf.mouseEnabled = false;
			tf.y = bg.height / 2 - tf.height / 2;
			
			var hit:Rect = new Rect(bg.width, bg.height, 0xff00aa);
			hit.alpha = 0;
			addChild(hit);
			hit.buttonMode = true;
			
			hit.addEventListener(MouseEvent.MOUSE_OVER, function(e:MouseEvent) {
				bg.graphics.clear();
				bg.graphics.lineStyle(1, hoverColor);
				bg.graphics.beginFill(hoverColor);
				drawBg();
				tf.textColor = 0xffffff;
			});
			hit.addEventListener(MouseEvent.MOUSE_OUT, function(e:MouseEvent) {
				
				bg.graphics.clear();
				bg.graphics.lineStyle(1, borderColor);
				bg.graphics.beginFill(0xffffff);
				drawBg();
				tf.textColor = textColor;
			});
		}
		// privates
		private function drawBg() {
			bg.graphics.drawRoundRect(0, 0, btnwidth, btnheight, 4, 4);
		}
		
		
	}//end-class
}//end-pack