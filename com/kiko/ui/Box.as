package com.kiko.ui
{
	/**
	 * Version 1.04
	 * 
	 * 
	 * todo
	 * - alle listeners mit weakReference versehen
	 * - korrekte Anordung der grabberButtons OK
	 * - schnelle dispose funktion
	 */
	// adobe
	import flash.display.Sprite;
	import flash.display.SimpleButton;
	import flash.display.LineScaleMode;
	import flash.display.JointStyle;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	//
	// own
	import com.kiko.display.*;
	import com.kiko.ui.*;
	import com.kiko.ui.buttons.*;
	//
	public class Box extends Sprite
	{
		// graphics
		private var bg:Sprite;
		private var grabber:Grabber;
		private var scrollContent:ScrollContent;
		private var content:Sprite;
		private var whiteSpace:Sprite;
		private var format:TextFormat;
		private var title_tf:TextField;
		private var scroller_x:ScrollElement;
		private var scroller_y:ScrollElement;
		//
		//
		// flags
		private var closed:Boolean;
		//
		// data
		private var contentElements:Number = 0;
		private var contentHeight:Number = 0;
		private var elementGap:Number = 10;
		//
		//
		public function Box():void{
			trace("Box  ---  inited");
			this.addEventListener(Event.ADDED_TO_STAGE, toStage);
		}
		
		private function toStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, toStage);
			draw();
			eventListeners();
		}
		
		
		
		private function draw():void {
			bg = new Sprite();
			bg.graphics.beginFill(0xffffff);
			bg.graphics.lineStyle(1, 0xdedede, 1, false, LineScaleMode.NONE, null);
			bg.graphics.drawRect(0, 0, 200, 300);
			addChild(bg);
			
			grabber = new Grabber();
			grabber.graphics.beginFill(0xffffff);
			grabber.graphics.lineStyle(1, 0xdedede, 1, false, LineScaleMode.NONE );
			grabber.graphics.drawRect(0, 0, 200, 35);
			addChild(grabber);
			grabber.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent) {
				startDrag();
			});
			
			// grabber buttons
			var close:IconButton = addGrabberButton("resources/swf/cross_icon.swf");
			var minimize:IconButton = addGrabberButton("resources/swf/minimize_icon.swf");
			addGrabberButton("resources/swf/invisible_icon.swf");
			//addGrabberButton("resources/swf/more_icon.swf");
			var more:IconButton = addGrabberButton("resources/swf/test_icon.swf");
			
			
			
			scroller_y = new ScrollElement(stage, 0xffffff,0xcccccc);
			addChild(scroller_y);
			scroller_y.alpha = 1;
			scroller_y.scrollBackgroundWidth = 0;
			scroller_y.scrollBackgroundHeight = bg.height - grabber.height;
			scroller_y.x = bg.width - scroller_y.width - 0;
			scroller_y.y = 36;
			scroller_y.scrollerWidth = 5;
			scroller_y.scrollBackground.alpha = 0;
			scroller_y.scroller.alpha = 0.5;
			scroller_y.scrollMode = ScrollElement.VERTICAL_SCROLL;
			
			scroller_x = new ScrollElement(stage, 0xffffff,0xcccccc);
			addChild(scroller_x);
			scroller_x.alpha = 1;
			scroller_x.scrollBackgroundWidth = bg.width;
			scroller_x.scrollBackgroundHeight = 5;
			scroller_x.x = 0;
			scroller_x.y = this.height - scroller_x.scrollBackgroundHeight;
			scroller_x.scrollerHeight = 5;
			scroller_x.scrollBackground.alpha = 0;
			scroller_x.scroller.alpha = 0.5;
			scroller_x.scrollMode = ScrollElement.HORIZONTAL_SCROLL;
			
			// scroll content
			content = new Sprite();
			scrollContent = new ScrollContent(content, new <ScrollElement>[scroller_y, scroller_x]);
			addChild(scrollContent);
			scrollContent.y = grabber.height+5;
			scrollContent.displayWidth = bg.width;
			scrollContent.displayHeight = bg.height - grabber.height-10;
			
			format = new TextFormat("Arial", 12, 0x999999);
			title_tf = new TextField();
			title_tf.text = "Super Viewer";
			title_tf.setTextFormat(format);
			title_tf.autoSize = TextFieldAutoSize.RIGHT;
			title_tf.mouseEnabled = false;
			addChild(title_tf);
			title_tf.x = bg.width - title_tf.width - 15;
			title_tf.y = grabber.height / 2 - title_tf.height / 2;
			
			
			addEventListener(MouseEvent.MOUSE_WHEEL, function(e:MouseEvent) {
				scroller_y.scrollerY -= e.delta*2.5;
			});
			
			/* colors
			 * blue: 0x4a55ff
			 * 
			 * 
			 * */
			
			
			
			// button clicks
			minimize.addEventListener(MouseEvent.CLICK, function() {
				bg.visible = closed ? true : false;
				content.visible = closed ? true : false;
				scroller_y.visible = closed ? true : false;
				scroller_x.visible = closed ? true : false;
				closed = !closed;
			});
			
			var me:Box = this;
			close.addEventListener(MouseEvent.CLICK, function() { 
				me.parent.removeChild(me);
			});
			
			more.addEventListener(MouseEvent.CLICK, function() {
				width = Math.random() * 800;
				height = Math.random() * 800;
			});
			
			// dropshadow
			this.filters = [new DropShadowFilter(0, 0, 0, 0.05, 10, 10, 1, 3)];
			
			// display list
			this.setChildIndex(scroller_x, numChildren - 1);
			this.setChildIndex(scroller_y, numChildren - 1);
			
		}
		
		// privates
		private function eventListeners():void {
			stage.addEventListener(MouseEvent.MOUSE_UP, function(e:MouseEvent) {
				stopDrag();
			});
			
			var me = this;
			this.addEventListener(MouseEvent.MOUSE_DOWN, function() {
				parent.setChildIndex(me, parent.numChildren - 1);
			});
			
			addEventListener(Event.ENTER_FRAME, function() {
				if(!closed) {
				scroller_x.visible = scroller_x.scrollerWidth >= scroller_x.scrollBackgroundWidth ? false : true;
				scroller_y.visible = scroller_y.scrollerHeight >= scroller_y.scrollBackgroundHeight ? false : true;
				}
			});
		}
		
		
		//publics
		public function addGrabberButton(icoPath:String):IconButton {
			var but:IconButton = new IconButton(icoPath, function() {
				addChild(but);
				var xpos:Number = grabber.startX;
				for (var i:uint = 0; i < grabber.buttons.length; i++) {
					var b:IconButton = grabber.buttons[i];
					b.x = xpos;
					xpos += b.width;
				}
				//but.x = grabber.contentWidth;
				//grabber.contentWidth += but.width + 0;
			}, new Rect(25,grabber.height,0xff00aa),true);
			but.buttonMode = true;
			grabber.addButton(but);
			//
			
			//
			but.addEventListener(MouseEvent.MOUSE_OVER, function() { 
				but.alpha = 0.5;
			});
			but.addEventListener(MouseEvent.MOUSE_OUT, function() { 
				but.alpha = 1;
			});
			return but;
		}
		
		public function addTextButton(text:String, color:uint = 0x656565):TextButton {
			removeWhiteSpace();
			var tb:TextButton;
			if(color == 0x656565) tb = new TextButton(text, 180, 25, 0x656565, 0x9F9F9F, 0x9F9F9F );
			else tb = new TextButton(text, 180, 25, color, color, color );
			content.addChild(tb);
			tb.x = 10;
			tb.y = contentHeight+1;
			contentElements ++;
			contentHeight += tb.height + elementGap;
			addWhiteSpace();
			return tb;
		}
		public function addToggleButton(text, toggleColor):ToggleButton {
			removeWhiteSpace();
			var tg:ToggleButton = new ToggleButton(text);
			content.addChild(tg);
			tg.x = 10;
			tg.y = contentHeight+1;
			contentElements ++;
			contentHeight += tg.height + elementGap;
			addWhiteSpace();
			return tg;
		}
		public function addSlider(text:String, minVal:Number, maxVal:Number, startVal:Number):Slider {
			removeWhiteSpace();
			var s:Slider = new Slider(stage, text, minVal, maxVal, startVal, 180);
			content.addChild(s);
			s.x = 10;
			s.y = contentHeight;
			//s.width = this.width - 20;
			contentElements ++;
			contentHeight += s.height + elementGap;
			addWhiteSpace();
			return s;
		}
		
		/**
		 * Fügt einen Leerraum ganz am Schluss des Contents ein, um ein bisschen Weissraum zu erzeugen.
		 */
		private function addWhiteSpace():void {
			whiteSpace = new Sprite();
			whiteSpace.graphics.beginFill(0xff00aa, 0);
			whiteSpace.graphics.drawRect(0, 0, 100, 25);
			content.addChild(whiteSpace);
			whiteSpace.y = contentHeight;
			contentHeight += whiteSpace.height + elementGap;
		}
		private function removeWhiteSpace():void {
			if (whiteSpace && content.contains(whiteSpace)) {
				contentHeight -= whiteSpace.height + elementGap;
				content.removeChild(whiteSpace);
			}
		}
		
		// getters  setters
		public function set title(value:String):void {
			this.title_tf.text = value;
			title_tf.setTextFormat(format);
		}
		public function get title():String {
			return this.title_tf.text;
		}
		
		override public function get width () : Number {
			return bg.width;
		}
		override public function set width (value:Number) : void {
			bg.width = value;
			grabber.width = value;
			title_tf.x = value - title_tf.width - 15;
			scrollContent.displayWidth = value;
			scroller_x.scrollBackgroundWidth = value;
			scroller_x.scrollerXToMin();
			scroller_y.x = value - scroller_y.scrollBackgroundWidth;
		}
		
		override public function get height () : Number {
			return bg.height;
		}
		override public function set height (value:Number) : void {
			bg.height = value;
			scrollContent.displayHeight = value - grabber.height - 10;
			scroller_y.scrollBackgroundHeight = value - grabber.height;
			scroller_x.y = bg.height - scroller_x.scrollBackgroundHeight;
		}
		
	}//end-class
}//end-pack