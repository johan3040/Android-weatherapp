package as3.middle{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.*;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import as3.middle.CurrentExtraInfo;
	
	//
	// Class for instantiateing compass symbol, position and print text regarding wind direction.
	//
	
	public class Comp extends CurrentExtraInfo{
		
		private var compassText:TextField;
		private var compassDir:TextField;
		private var compass;
		private var compassNeedle:CompassNeedle;
		private var num:int = 0;
		private var timer:uint;
		private const COMPASS_X:int = 65;
		
		public function Comp(data):void{
			super(data);
			initCompassText();
			initCompass();
			initCompassNeedle();
			}
		
		private function initCompassText(){

			this.compassText = new TextField();
			
			var format = new TextFormat();
			format.font = FONT;
			format.size = FONT_SIZE;
			format.color = fontColor;
			
			this.compassText.embedFonts = true;
			this.compassText.autoSize = TextFieldAutoSize.CENTER;
			this.compassText.text = data.current.wind_kph.toString() + " km/h";			
			this.compassText.setTextFormat(format);

			addChild(this.compassText);
			this.compassText.addEventListener(Event.ADDED_TO_STAGE, positionCompassText);
			}	
			
		private function positionCompassText(e:Event):void{

			this.compassText.x = (stage.stageWidth/100)*65;
			this.compassText.y = (stage.stageHeight/100)*TEXT_Y;

			}

		//
		// Depending on value set on 'day', either light-themed or dark-themed compass will be instantiated
		//
		private function initCompass():void{
			
			day ? this.compass = new CompassDay() : this.compass = new CompassNight();
			
			addChild(this.compass);
			this.compass.addEventListener(Event.ADDED_TO_STAGE, positionCompass);
			
			}
			
		private function positionCompass(e:Event){

			this.compass.x = (stage.stageWidth/100)*COMPASS_X;
			this.compass.y = (stage.stageHeight/100)*ICON_Y;
			
			}
		
		private function initCompassNeedle():void{
			
			this.compassNeedle = new CompassNeedle();
			addChild(this.compassNeedle);
			this.compassNeedle.addEventListener(Event.ADDED_TO_STAGE, positionCompassNeedle);
			
			}
		
		//
		// Sets position for compassneedle, and if the wind degree is not 0, rotateCompass function is called
		//
		private function positionCompassNeedle(e:Event):void{

			this.compassNeedle.x = ((stage.stageWidth/100)*COMPASS_X) + (this.compass.width/2)-2; //Riktig fuling det där....
			this.compassNeedle.y = ((stage.stageHeight/100)*ICON_Y) + (this.compass.height/2);
			
			if(this.data.current.wind_degree != 0){
				this.timer = setInterval(rotateCompass, 12);
				}			
			}
			
		//
		// Rotates compass needle to correct wind degree.
		// Will turn either clockwise or counter clockwise, depending on wind_degree value 
		// (Always takes the shortest way to the position)
		//
		private function rotateCompass():void{
			
			if(this.data.current.wind_degree == this.num || this.data.current.wind_degree == (180 + (this.num+180))){
					
					clearInterval(this.timer);
					
					}
			
			if(this.data.current.wind_degree <= 180 && this.data.current.wind_degree > 0){
				
				this.compassNeedle.rotation = this.num;
				this.num++;
				
				}else {
					
					this.compassNeedle.rotation = this.num;
					this.num--;
					
					}
			}
			
		}
	
	
}