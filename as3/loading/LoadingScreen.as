package  as3.loading{
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.display.Sprite;
	import as3.fonts.Font;
	
	
	//
	// Public class for instantiating loading screen
	// Creates textfield and sets value to text
	//
	
	public class LoadingScreen extends Sprite{

		private var loadingText:TextField;
		private const FONT: String = "MontserratLight";
		
		public function LoadingScreen() {
			var font = new Font();
			initLoadingScreen();
		}
		
		private function initLoadingScreen():void{
			
			this.loadingText = new TextField();
			var format = new TextFormat();
			format.font = FONT;
			format.size = 36;
			this.loadingText.embedFonts = true;
			this.loadingText.width = 150;
			this.loadingText.text = "Loading";
			this.loadingText.setTextFormat(format);
			addChild(this.loadingText);
			this.loadingText.addEventListener(Event.ADDED_TO_STAGE, positionLoading);
			
			}
			
			private function positionLoading(e:Event):void{
				
			this.loadingText.removeEventListener(Event.ADDED_TO_STAGE, positionLoading);
			
			this.loadingText.x = (stage.stageWidth/2) - (this.loadingText.width/2);
			this.loadingText.y = (stage.stageHeight/2) - (this.loadingText.height/2);
			}

	}
	
}
