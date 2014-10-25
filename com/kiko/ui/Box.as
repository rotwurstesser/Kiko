﻿package com.kiko.ui
{
	/**
	 * Version 1.06
	 * 
	 * 
	 * @todo
	 * - alle listeners mit weakReference versehen
	 * - schnelle dispose funktion
	 * - BoxManager der die active boxes verwaltet.
	 */
	// adobe
	import flash.display.Sprite;
	import flash.display.SimpleButton;
	import flash.display.LineScaleMode;
	import flash.display.JointStyle;
	import flash.display.CapsStyle;
	import flash.filters.ColorMatrixFilter;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.ui.Mouse;
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
		private var closeButton:IconButton;
		private var minimizeButton:IconButton;
		private var circleButton:IconButton;
		private var colorCircle:Sprite;
		private var moreButton:IconButton;
		private var resizer:Image;
		//
		//
		// flags
		private var _active:Boolean = true;
		private var closed:Boolean;
		private var circleMode:Boolean;
		private var resizing:String;
		//
		// data
		private var contentElements:Number = 0;
		private var contentHeight:Number = 0;
		private var elementGap:Number = 8;
		private var _color:uint;
		private var resize_area:Number = 5; // std:5
		private var positions:Positions = new Positions();
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
			initListeners();
		}
		
		
		
		private function draw():void {
			var self:Box = this;
			bg = new Sprite();
			bg.graphics.beginFill(0xffffff);//0xffffff
			bg.graphics.lineStyle(1, 0xdedede, 1, false, LineScaleMode.NORMAL, null, JointStyle.MITER); //0xdedede
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
			
			colorCircle = new Sprite();
			colorCircle.graphics.lineStyle(2, Math.random()*0xffffff);
			colorCircle.graphics.beginFill(0xffffff);
			colorCircle.graphics.drawCircle(0, 0, 7);
			addChild(colorCircle);
			colorCircle.visible = false;
			colorCircle.buttonMode = true;
			colorCircle.doubleClickEnabled = true;
			colorCircle.addEventListener(MouseEvent.MOUSE_DOWN, function() {
				colorCircle.startDrag();
			});
			colorCircle.addEventListener(MouseEvent.DOUBLE_CLICK, clickCircle);
			
			// grabber buttons
			closeButton = addGrabberButton("resources/swf/cross_icon.swf");
			//minimizeButton = addGrabberButton("resources/swf/minimize_icon.swf");
			circleButton = addGrabberButton("resources/swf/invisible_icon.swf");
			//addGrabberButton("resources/swf/more_icon.swf");
			//moreButton = addGrabberButton("resources/swf/test_icon.swf");
			
			resizer = new Image("resources/swf/arrow_icon.swf", function() {
			},true);
			self.addChild(resizer);
			resizer.visible = false;
			
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
			
			format = new TextFormat("Arial", 12, 0x555555, false); //blue: 0x4a55ff
			title_tf = new TextField();
			title_tf.text = "New Box";
			title_tf.setTextFormat(format);
			title_tf.autoSize = TextFieldAutoSize.RIGHT;
			title_tf.mouseEnabled = false;
			addChild(title_tf);
			title_tf.x = bg.width - title_tf.width - 15;
			title_tf.y = grabber.height / 2 - title_tf.height / 2;
			
			// mouse wheel
			addEventListener(MouseEvent.MOUSE_WHEEL, function(e:MouseEvent) {
				scroller_y.scrollerY -= e.delta*2.5;
			});
			
			/**
			 * @temp Unbestimmt, ob benötigt
			 */
			// button clicks
			/*minimizeButton.addEventListener(MouseEvent.CLICK, function() {
				if (!circleMode) {
				bg.visible = closed;
				content.visible = closed;
				scroller_y.visible = closed;
				scroller_x.visible = closed;
				closed = !closed;
				}
			});*/
			
			/**
			 * @todo dispose Funktion einbauen zum entfernen von Listeneren und Referenzen.
			 */
			closeButton.addEventListener(MouseEvent.CLICK, function() {
				if(hasEventListener(Event.ENTER_FRAME)) removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				if(stage.hasEventListener(MouseEvent.MOUSE_DOWN)) stage.removeEventListener(MouseEvent.MOUSE_DOWN, stageMouseDown);
				if (stage.hasEventListener(MouseEvent.MOUSE_UP)) stage.removeEventListener(MouseEvent.MOUSE_UP, stageMouseUp);
				self.parent.removeChild(self);
			});
			
			circleButton.addEventListener(MouseEvent.CLICK, clickCircle);
			
			/*moreButton.addEventListener(MouseEvent.CLICK, function() {
				width = content.width + 15;
				height = content.height + 15;
			});*/
			
			
			// dropshadow
			this.filters = [new DropShadowFilter(0, 0, 0, 0.05, 10, 10, 1, 3)];
			
			// display list
			this.setChildIndex(scroller_x, numChildren - 1);
			this.setChildIndex(scroller_y, numChildren - 1);
			this.setChildIndex(resizer, numChildren - 1);
			
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// privates
		private function initListeners():void {
			var self:Box = this;
			stage.addEventListener(MouseEvent.MOUSE_UP, function(e:MouseEvent) {
				stopDrag();
				colorCircle.stopDrag();
			});
			this.addEventListener(MouseEvent.MOUSE_DOWN, function() {
				parent.setChildIndex(self, parent.numChildren - 1);
			});
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
		
		private function clickCircle(e:MouseEvent):void {
			if(!closed){
			grabber.visible = circleMode;
			bg.visible = circleMode;
			content.visible = circleMode;
			scroller_x.visible = circleMode;
			scroller_y.visible = circleMode;
			title_tf.visible = circleMode;
			for ( var i:uint = 0; i < grabber.buttons.length; i++) {
				(grabber.buttons[i] as IconButton).visible = circleMode;
			}
			placeColorCirlce();
			colorCircle.visible = !circleMode;
			circleMode = !circleMode;
			}
		}
		/**
		 * Platziert den colorCircle an die Position des KreisIcons.
		 */
		private function placeColorCirlce():void {
			colorCircle.x = circleButton.x + circleButton.width/2;
			colorCircle.y = circleButton.y + circleButton.height/2;
		}
		private function onEnterFrame(e:Event):void {
			// scrollbar visibility
			if(!closed && !circleMode) {
			scroller_x.visible = scroller_x.scrollerWidth >= scroller_x.scrollBackgroundWidth ? false : true;
			scroller_y.visible = scroller_y.scrollerHeight >= scroller_y.scrollBackgroundHeight ? false : true;
			}
			
			//resize areas
			var a:Number = resize_area;
			positions.a_left = new Rectangle(this.x - a, this.y, a * 2, this.height - 2*a);
			positions.a_right = new Rectangle(this.x + this.width, this.y, a * 2, this.height - 2*a);
			positions.a_bottom = new Rectangle(this.x + 2*a, this.y + this.height, this.width - 4*a, a * 2);
			positions.a_bottom_left = new Rectangle(this.x -a*2, this.y + this.height -a*2, a * 4, a * 4);
			positions.a_bottom_right = new Rectangle(this.x + this.width -a*2, this.y + this.height -a*2, 4 * a, 4 * a);
			var s:Point = new Point(stage.mouseX, stage.mouseY);
			
			//resizer visibility
			if (positions.a_right.containsPoint(s) || 
			positions.a_left.containsPoint(s) ||
			positions.a_bottom.containsPoint(s) ||
			positions.a_bottom_left.containsPoint(s) ||
			positions.a_bottom_right.containsPoint(s) ) {
				resizer.x = mouseX;
				resizer.y = mouseY;
				resizer.visible = true;
				Mouse.hide();
				if(!resizing) {
					if (positions.a_bottom_right.containsPoint(s)) {
						resizer.rotation = 45;
					}
					else if (positions.a_bottom_left.containsPoint(s)) {
						resizer.rotation = -45;
					}
					else if (positions.a_left.containsPoint(s) || positions.a_right.containsPoint(s)) {
						resizer.rotation = 0;
					}
					else if (positions.a_bottom.containsPoint(s)) {
						resizer.rotation = 90;
					}
				}
			}
			else {
				resizer.visible = false;
				Mouse.show();
			}
			
			//resizing
			if (resizing) {
				resizer.x = mouseX;
				resizer.y = mouseY;
				resizer.visible = true;
				Mouse.hide();
				if (resizing == "left")	{
					this.x = Math.min(stage.mouseX);
					this.width = positions.rightEdgeX - stage.mouseX;
				}
				else if (resizing == "right") {
					this.width = stage.mouseX - this.x;
				}
				else if (resizing == "bottom") {
					this.height = mouseY;
				}
				else if (resizing == "bottom_right") {
					this.width = mouseX;
					this.height = mouseY;
				}
				else if (resizing == "bottom_left") {
					this.x = stage.mouseX;
					this.width = positions.rightEdgeX - stage.mouseX;
					this.height = mouseY;
				}
			}
			
		}
		private function stageMouseDown(e:MouseEvent):void {
			var s:Point = new Point(stage.mouseX, stage.mouseY);
			if 	(positions.a_right.containsPoint(s)) 	resizing = "right";
			else if (positions.a_left.containsPoint(s)) resizing = "left";
			else if (positions.a_bottom.containsPoint(s)) resizing = "bottom";
			else if (positions.a_bottom_left.containsPoint(s)) resizing = "bottom_left";
			else if (positions.a_bottom_right.containsPoint(s)) resizing = "bottom_right";
			else resizing = "";
			positions.rightEdgeX = this.x + this.width;
			positions.leftEdgeX = this.x;
			
			
			/**
			 * @debug Visualisierungen der resize areas
			 */
			if (0){
			var os:Array = [positions.a_bottom_left, positions.a_bottom_right, positions.a_bottom, positions.a_left, positions.a_right];
			for (var i:uint = 0; i < os.length; i++) {
				var o:Rectangle = os[i];
				var r:Rect = new Rect(o.width, o.height, 0xff00aa);
				addChild(r);
				var p:Point = globalToLocal( new Point(o.left, o.top));
				r.x = p.x;
				r.y = p.y;
				r.alpha = 0.3;
			}
			}
		}
		private function stageMouseUp(e:MouseEvent):void {
			resizing = "";
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//publics
		/**
		 * Fügt im Grabber einen neuen IconButton hinzu.
		 * @param	icoPath Pfad zum Icon. (*.swf, *.jpg ...)
		 * @return	Der erzeugte IconButton.
		 */
		public function addGrabberButton(icoPath:String ):IconButton {
			var but:IconButton = new IconButton(icoPath, function() {
				addChild(but);
				var xpos:Number = grabber.startX;
				for (var i:uint = 0; i < grabber.buttons.length; i++) {
					var b:IconButton = grabber.buttons[i];
					b.x = xpos;
					xpos += b.width;
				}
				// align colorCircle
				placeColorCirlce();
			},true, new Rect(25,grabber.height,0xff00aa));
			but.buttonMode = true;
			grabber.addButton(but);
			//
			but.addEventListener(MouseEvent.MOUSE_OVER, function() {
				if(active) but.alpha = 0.5;
			});
			but.addEventListener(MouseEvent.MOUSE_OUT, function() { 
				if(active) but.alpha = 1;
			});
			return but;
		}
		/**
		 * @param	text Button Text
		 * @param	color Textfarbe, Randfarbe und Hoverfarbe. zB: 0x4a55ff
		 * @return	Der erstellte TextButton
		 */
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
		public function addToggleButton(text:String):ToggleButton {
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
		public function addSlider(text:String, minVal:Number, maxVal:Number, startVal:Number, showValueLimits:Boolean = true):Slider {
			removeWhiteSpace();
			var s:Slider = new Slider(stage, text, minVal, maxVal, startVal, showValueLimits, 180);
			content.addChild(s);
			s.x = 10;
			s.y = contentHeight+1;
			//s.width = this.width - 20;
			contentElements ++;
			contentHeight += s.height + elementGap;
			addWhiteSpace();
			return s;
		}
		public function addStepper(text:String, minVal:int, maxVal:int, startVal:int, stepVal:int = 1):Stepper {
			removeWhiteSpace();
			var sp:Stepper = new Stepper(text, minVal, maxVal, startVal, stepVal, 180);
			content.addChild(sp);
			sp.x = 10;
			sp.y = contentHeight+1;
			contentElements++;
			contentHeight += sp.height + elementGap;
			addWhiteSpace();
			return sp;
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// getters  setters
		public function set title(value:String):void {
			this.title_tf.text = value;
			title_tf.setTextFormat(format);
		}
		public function get title():String {
			return this.title_tf.text;
		}
		/**
		 * @todo Aufräumen, definieren was alles aktiv ist und was nicht.
		 */
		public function set active(bool:Boolean):void {
			_active = bool;
			var opacity:Number;
			var opacity2:Number;
			var opacity3:Number;
			var dropshadow:DropShadowFilter;
			var blur:BlurFilter;
			var rc:Number = 1/3, gc:Number = 1/3, bc:Number = 1/3;
			var cmf:ColorMatrixFilter = new ColorMatrixFilter([rc, gc, bc, 0, 0, rc, gc, bc, 0, 0, rc, gc, bc, 0, 0, 0, 0, 0, 1, 0]);
			var color:uint;
			if (bool) {
				opacity = 1;
				opacity2 = 1;
				opacity3 = 1;
				dropshadow = new DropShadowFilter(0, 0, 0, 0.05, 18, 18, 2.5, 3);
				blur = new BlurFilter(0, 0, 0);
				color = this.color; //0x555555
				//content.filters = [];
				addEventListener(Event.ENTER_FRAME, onEnterFrame);
				stage.addEventListener(MouseEvent.MOUSE_DOWN, stageMouseDown);
				stage.addEventListener(MouseEvent.MOUSE_UP, stageMouseUp);
			}
			else {
				opacity = 0.2;
				opacity2 = 0.5;
				opacity3 = 0;
				dropshadow = new DropShadowFilter(0, 0, 0, 0.05, 10, 10, 1, 3);
				blur = new BlurFilter(2, 2, 3);
				color = 0x999999; //0xD2D2D2
				//content.filters = [cmf];
				if(hasEventListener(Event.ENTER_FRAME)) removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				if(stage.hasEventListener(MouseEvent.MOUSE_DOWN)) stage.removeEventListener(MouseEvent.MOUSE_DOWN, stageMouseDown);
				if (stage.hasEventListener(MouseEvent.MOUSE_UP)) stage.removeEventListener(MouseEvent.MOUSE_UP, stageMouseUp);
			}
			for (var i:uint = 0; i < grabber.buttons.length; i++) {
				grabber.buttons[i].alpha = opacity;
			}
			this.filters = [dropshadow];
			//content.alpha = opacity2;
			scroller_x.alpha = opacity3;
			scroller_y.alpha = opacity3;
			title_tf.textColor = color;	
		}
		public function get active():Boolean {
			return _active;
		}
		public function set color(c:uint):void {
			this._color = c;
			colorCircle.graphics.clear();
			colorCircle.graphics.lineStyle(2, c);
			colorCircle.graphics.beginFill(0xffffff);
			colorCircle.graphics.drawCircle(0, 0, 7);
			title_tf.textColor = color;	
		}
		public function get color():uint {
			return _color;
		}
		override public function get width () : Number {
			return bg.width;
		}
		override public function set width (value:Number) : void {
			/**
			 * @temp 120 = minWidth
			 */
			value = Math.max(120, value);
			bg.width = value;
			grabber.width = value;
			title_tf.x = value - title_tf.width - 15;
			scrollContent.displayWidth = value - 8;
			scroller_x.scrollBackgroundWidth = value;
			scroller_x.scrollerXToMin();
			scroller_y.x = value - scroller_y.scrollBackgroundWidth-2;
		}
		override public function get height () : Number {
			return bg.height;
		}
		override public function set height (value:Number) : void {
			/**
			 * @temp 60 = minHeight
			 */
			value = Math.max(60, value);
			bg.height = value;
			scrollContent.displayHeight = value - grabber.height - 10;
			scroller_y.scrollBackgroundHeight = value - grabber.height;
			scroller_x.y = bg.height - scroller_x.scrollBackgroundHeight;
		}
		
	}//end-class
}//end - pack
//
import flash.geom.Rectangle;
dynamic class Positions {
	public var a_left:Rectangle = new Rectangle();
	public var a_right:Rectangle = new Rectangle();
	public var a_bottom:Rectangle = new Rectangle();
	public var a_bottom_left:Rectangle = new Rectangle();
	public var a_bottom_right:Rectangle = new Rectangle();
	//
	public var rightEdgeX:Number;
	public var leftEdgeX:Number;
}