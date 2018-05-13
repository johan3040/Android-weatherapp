package  as3.errorhandler{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.events.Event;
	import as3.fonts.Font;
	
	
	import flash.events.MouseEvent;
	

	//
	//Class for creating errorWindows.
	// this.callback = Main.clearStage method
	//
	
	public class ErrorWindow extends Sprite{
		
		private var errorMsg:TextField;
		private var msg:String;
		private var bg:DayBg;
		
		private var callback:Function;
		
		public function ErrorWindow(msg, callback) {
			var font = new Font();
			this.msg = msg;
			this.callback = callback;
			initErrorMsg();
		}
		
		private function initErrorMsg():void{
			Multitouch.inputMode=MultitouchInputMode.TOUCH_POINT;
			this.bg = new DayBg();
			addChild(this.bg);
			
			this.errorMsg = new TextField();
			var format:TextFormat = new TextFormat()
			format.font = "MontserratLight";
			format.size = 36;
			
			this.errorMsg.embedFonts = true;
			this.errorMsg.text = msg;
			this.errorMsg.setTextFormat(format);
			this.errorMsg.autoSize = TextFieldAutoSize.LEFT;
			
			this.bg.addEventListener(TouchEvent.TOUCH_TAP, this.callback);
			this.errorMsg.addEventListener(TouchEvent.TOUCH_TAP, this.callback);
			
			
			this.errorMsg.addEventListener(Event.ADDED_TO_STAGE, positionErrMsg);
			addChild(this.errorMsg);
			
			}
			
		private function positionErrMsg(e:Event):void{
			
			this.errorMsg.y = stage.stageHeight/2 - this.errorMsg.height/2;
			
			}

	}
	
}
