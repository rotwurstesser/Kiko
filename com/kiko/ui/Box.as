package com.kiko.ui
{
	/**
	 * Version 1.02
	 */
	// adobe
	import flash.display.Sprite;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
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
		//
		// flags
		private var closed:Boolean;
		//
		// data
		private var contentElements:Number = 0;
		private var contentHeight:Number = 45;
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
			bg.graphics.lineStyle(1, 0xdedede);
			bg.graphics.drawRect(0, 0, 200, 300);
			addChild(bg);
			
			grabber = new Grabber();
			grabber.numButtons = 0;
			grabber.graphics.beginFill(0xffffff);
			grabber.graphics.lineStyle(1, 0xdedede);
			grabber.graphics.drawRect(0, 0, 200, 35);
			addChild(grabber);
			grabber.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent) {
				startDrag();
			});
			
			var close:IconButton = addGrabberButton("resources/swf/cross_icon.swf");
			var minimize:IconButton = addGrabberButton("resources/swf/minimize_icon.swf");
			addGrabberButton("resources/swf/invisible_icon.swf");
			
			//addTextButton("New Super", 0x656565, 0xcccccc, 0x9F9F9F);
			//addTextButton("New Super", 0x656565, 0xcccccc, 0x9F9F9F);
			//addTextButton("New Super", 0x656565, 0xcccccc, 0x9F9F9F);
			var c = Math.random() * 0xffffff;
			//addTextButton("New Super", c, c, c);
			//addTextButton("Test Alert Button", 0xff3443, 0xff3443, 0xff3443);
			//addTextButton("Notice", 0x4a55ff, 0x4a55ff, 0x4a55ff);
			//addToggleButton("Toggle Checkbox", 0xd5ffa5);
			addSlider("Banana Count", 0, 100);
			addSlider("Drink Count", 50, 80);
			addTextButton("New Super", 0x656565, 0xcccccc, 0x9F9F9F);
			addTextButton("New Super", 0xff3443, 0xff3443, 0xff3443);
			addToggleButton("Toggle Checkbox", 0xd5ffa5);
			addToggleButton("New", 0xff00aa);
			
			
		


			
			minimize.addEventListener(MouseEvent.CLICK, function() {
				bg.visible = closed ? true : false;
				closed = !closed;
			});
			
			var me = this;
			this.addEventListener(MouseEvent.MOUSE_DOWN, function() {
				parent.setChildIndex(me, parent.numChildren - 1);
			});
			
			// dropshadow
			this.filters = [new DropShadowFilter(0, 0, 0, 0.05, 10, 10, 1, 3)];
			
			
			var scroller_x:ScrollElement = new ScrollElement(stage, 0xffffff,0xcccccc);
			addChild(scroller_x);
			scroller_x.alpha = 0;
			scroller_x.scrollBackgroundWidth = 10;
			scroller_x.scrollBackgroundHeight = bg.height - grabber.height;
			scroller_x.x = bg.width - scroller_x.width - 2;
			scroller_x.y = 36;
			scroller_x.scrollerWidth = 10;
			scroller_x.scrollBackground.alpha = 0;
			scroller_x.scroller.alpha = 0.5;
			
			/**
			 * todo
			 * scrollcontent, scrollbars, resizers
			 */
			/*
			var cb:ScrollContent = new ScrollContent(new Rect(20, 20, 0xff00aa), new Vector.<ScrollElement>(new ScrollElement(stage),new ScrollElement(stage)) );
			addChild(cb);
			*/
		}
		
		private function eventListeners():void {
			stage.addEventListener(MouseEvent.MOUSE_UP, function(e:MouseEvent) {
				stopDrag();
			});
		}
		
		
		//publics
		public function addGrabberButton(icoPath:String):IconButton {
			var but:IconButton = new IconButton(icoPath, function() {
				addChild(but);
				//but.y = grabber.height / 2 - but.height / 2;
			}, new Rect(25,grabber.height,0xff00aa),true);
			
			but.x = 8 + grabber.numButtons * 25;
			grabber.numButtons++;
			//
			but.buttonMode = true;
			
			but.addEventListener(MouseEvent.MOUSE_OVER, function() { 
				but.alpha = 0.5;
			});
			but.addEventListener(MouseEvent.MOUSE_OUT, function() { 
				but.alpha = 1;
			});
			return but;

			//but.y = 
		}
		
		public function addTextButton(text, textColor, borderColor, hoverColor ):void {
			var tb:TextButton = new TextButton(text, 180, 25, textColor, borderColor, hoverColor );
			addChild(tb);
			tb.x = 10;
			tb.y = contentHeight;
			contentElements ++;
			contentHeight += tb.height + elementGap;
		}
		
		public function addToggleButton(text, toggleColor) {
			var tg:ToggleButton = new ToggleButton(text);
			addChild(tg);
			tg.x = 10;
			tg.y = contentHeight;
			contentElements ++;
			contentHeight += tg.height + elementGap;
		}
		
		public function addSlider(text, minVal, maxVal) {
			var s:Slider = new Slider(stage, text, minVal, maxVal, 180);
			addChild(s);
			s.x = 10;
			s.y = contentHeight;
			contentElements ++;
			contentHeight += s.height + elementGap;
		}
		
	}//end-class
}//end-pack