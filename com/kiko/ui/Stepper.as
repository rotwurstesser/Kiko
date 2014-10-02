package com.kiko.ui
{
	/**
	 * Version 1.02
	* todo:
		 * kommastellige Zahlen unterstützen
	 */
	// adobe
	import com.kiko.display.Image;
	import com.kiko.ui.buttons.IconButton;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.LineScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	//
	// own
	import com.kiko.display.Rect;
	//
	public class Stepper extends Sprite
	{
		// data
		private var _value:Number;
		private var _text:String;
		//
		// graphics
		private var bg:Sprite;
		private var boundaryLine:Sprite;
		private var format:TextFormat;
		private var tf:TextField;
		private var upButton:IconButton;
		private var downButton:IconButton;
		//
		//
		public function Stepper(text:String, minVal:int, maxVal:int, startVal:int, stepVal:int, width:uint ):void
		{
			if (startVal < minVal) startVal = minVal;
			if (startVal > maxVal) startVal = maxVal;
			_value = startVal;
			_text = text;
			
			bg = new Sprite();
			bg.graphics.lineStyle(1, 0x999999, 1, false, LineScaleMode.NONE);
			bg.graphics.beginFill(0xffffff);
			bg.graphics.drawRoundRect(0, 0, width, 35, 4, 4);
			addChild(bg);
			
			boundaryLine = new Sprite();
			boundaryLine.graphics.lineStyle(1, 0x999999, 1, false, LineScaleMode.NONE);
			boundaryLine.graphics.moveTo(0, 0);
			boundaryLine.graphics.lineTo(0, bg.height-1	);
			boundaryLine.x = bg.width - 40;
			addChild(boundaryLine);
			
			format = new TextFormat("Arial", 12, 0x656565);
			tf = new TextField();
			tf.text = _text + ": " + _value;
			addChild(tf);
			tf.setTextFormat(format);
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.x = 10;
			tf.selectable = false;
			tf.mouseEnabled = false;
			tf.y = bg.height / 2 - tf.height / 2;
			
			upButton = new IconButton("resources/swf/up_icon.swf", function(){
				addChild(upButton);
				upButton.x = bg.width - upButton.width-1;
				upButton.y = 0;
			}, new Rect(40 - 1, 20, 0xff0000), true );
			upButton.buttonMode = true;
			upButton.addEventListener(MouseEvent.MOUSE_OVER, overButton);
			upButton.addEventListener(MouseEvent.MOUSE_OUT, outButton);
			upButton.addEventListener(MouseEvent.CLICK, function() {
				value += 1;
				value = _value;
				trace(_value);
			});
			
			downButton = new IconButton("resources/swf/down_icon.swf", function(){
				addChild(downButton);
				downButton.x = bg.width - downButton.width-1;
				downButton.y = bg.height - downButton.height-1;
			}, new Rect(40 - 1, 20 - 1, 0xff0000), true );
			downButton.buttonMode = true;
			downButton.addEventListener(MouseEvent.MOUSE_OVER, overButton);
			downButton.addEventListener(MouseEvent.MOUSE_OUT, outButton);
			downButton.addEventListener(MouseEvent.CLICK, function() {
				value -= 1;
				value = _value;
			});
			
		}
		

		// privates
		private function overButton(e:MouseEvent):void {
			(e.currentTarget as IconButton).alpha = 0.5;
		}
		private function outButton(e:MouseEvent):void {
			(e.currentTarget as IconButton).alpha = 1;
		}

		// getters/setters
		override public function set width (value:Number) : void {
		}
		public function get value():Number {
			return _value;
		}
		public function set value(v:Number):void {
			_value = v;
			tf.text = _text + ": " + _value;
			tf.setTextFormat(format);
		}
	
		
	}//end-class
}//end-pack