package com.kiko.ui
{
	/**
	 * Version 1.01 
	 */
	// adobe
	import flash.display.Sprite
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.text.ime.CompositionAttributeRange;
	//
	// own
	import com.kiko.display.*;
	//
	public class Box extends Sprite
	{
		// graphics
		private var bg:Sprite;
		private var grabber:Grabber;
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
			
			var minimize:IconButton = addGrabberButton("resources/swf/minimize_icon.swf");
			var close:IconButton = addGrabberButton("resources/swf/cross_icon.swf");
			addGrabberButton("resources/swf/cross_icon.swf");
			
			
			minimize.addEventListener(MouseEvent.CLICK, function() {
				bg.visible = minimize.toggleOn ? false : true;
			});
			
			var me = this;
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, function() {
				parent.setChildIndex(me, parent.numChildren - 1);
			});
			
			this.filters = [new DropShadowFilter(0, 0, 0, 0.1, 10, 10, 1, 3)];
		}
		
		private function eventListeners():void {
			stage.addEventListener(MouseEvent.MOUSE_UP, function(e:MouseEvent) {
				stopDrag();
			});
		}
		
		
		//publics
		public function addGrabberButton(icoPath:String):IconButton {
			//var but:Image = new Image("resources/swf/cross_icon.swf", function() {
			var but:IconButton = new IconButton(icoPath, function() {
				addChild(but);
				but.y = grabber.height / 2 - but.height / 2;
				but.x = 12 + grabber.numButtons * 20;
				grabber.numButtons++;
			});
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
	}//end-class
}//end-pack