package  as3.day{
	
	import as3.day.MainDay;
	import flash.display.*;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Current extends MainDay {
		
		private var location:String;
		private var updated:String;
		private var conditionText:String;
		
		private var headerLocation:TextField;
		private var updatedText:TextField;
		private var degreeText:TextField;
		private var condText:TextField;
		
		private var weatherIcon;
		private var weatherVector:Vector.<MovieClip> = new Vector.<MovieClip>;
		
		private const BIG_SIZE:int 		= 32;
		private const STANDARD_SIZE:int = 18;
		private const SMALL_SIZE:int 	= 12;
		
		
		//Constructor
		public function Current(obj:Object) {
			super.isItDay(obj.current.is_day);
			
			deg 				= obj.current.temp_c;
			weatherCode 		= obj.current.condition.code;
			
			this.location 		= obj.location.name;
			this.updated 		= obj.current.last_updated;
			
			obj.current.is_day === 1 ? this.conditionText 	= getWeatherCode(weatherCode).day : this.conditionText 	= getWeatherCode(weatherCode).night;
			
			createVisibleHeader();
			createVisibleUpdated();
			createVisibleDeg();
			createVisibleConditionText();
			printIcons();
			
		}
		
		private function createVisibleHeader(){
			
			
			this.headerLocation 	= new TextField();
			var format:TextFormat 	= new TextFormat();
			format.size 			= BIG_SIZE;
			format.font 			= FONT;
			format.color			= fontColor;
			
			this.headerLocation.embedFonts = true; // -----importat -----
			this.headerLocation.text = this.location;
			this.headerLocation.autoSize = TextFieldAutoSize.CENTER;
			this.headerLocation.setTextFormat(format);
			
			addChild(this.headerLocation);
			this.headerLocation.addEventListener(Event.ADDED_TO_STAGE, positionHeader);
			}
			
		private function positionHeader(e:Event):void{
			this.headerLocation.removeEventListener(Event.ADDED_TO_STAGE, positionHeader);
			this.headerLocation.y = (stage.stageHeight/100)*2;
			this.headerLocation.x = (stage.stageWidth/100)*5.5;
			
			}
			
		private function createVisibleUpdated():void{
			
			this.updatedText 		= new TextField();
			var format:TextFormat 	= new TextFormat();
			format.size 			= SMALL_SIZE;
			format.font 			= FONT;
			format.color			= fontColor;
			
			this.updatedText.embedFonts = true;
			this.updatedText.text = "Last updated: " + this.updated;
			this.updatedText.autoSize = TextFieldAutoSize.LEFT;
			this.updatedText.setTextFormat(format);
			
			addChild(this.updatedText);
			this.updatedText.addEventListener(Event.ADDED_TO_STAGE, positionUpdated);
			
			}
			
		private function positionUpdated(e:Event):void{
			this.updatedText.removeEventListener(Event.ADDED_TO_STAGE, positionUpdated);
			this.updatedText.x = (stage.stageWidth/100)*5.5;
			this.updatedText.y = (stage.stageHeight/100)*95;
			
			}
		
		private function createVisibleDeg():void{
			
			this.degreeText = new TextField();
			var format:TextFormat = new TextFormat();
			format.size = 48;
			format.font = FONT;
			format.color = fontColor;
			
			this.degreeText.embedFonts = true;
			this.degreeText.width = 150;			
			this.degreeText.text = deg.toString() + " °C";
			this.degreeText.setTextFormat(format);
			
			addChild(this.degreeText);
			this.degreeText.addEventListener(Event.ADDED_TO_STAGE, positionDegree);
			
			}
			
		private function positionDegree(e:Event):void{
			this.degreeText.removeEventListener(Event.ADDED_TO_STAGE, positionDegree);
			this.degreeText.x = (stage.stageWidth/100)*5.5;
			this.degreeText.y = (stage.stageHeight/100)*9;
			
			}	
		
		private function createVisibleConditionText():void{

			this.condText = new TextField();
			var format:TextFormat = new TextFormat();
			format.size = STANDARD_SIZE;
			format.font = FONT;
			format.color = fontColor;
			
			this.condText.embedFonts = true; 
			this.condText.text = this.conditionText;
			this.condText.autoSize = TextFieldAutoSize.LEFT;
			this.condText.setTextFormat(format);
			
			addChild(this.condText);
			this.condText.addEventListener(Event.ADDED_TO_STAGE, positionCondition);
			
			}
			
		private function positionCondition(e:Event):void{
			this.condText.removeEventListener(Event.ADDED_TO_STAGE, positionCondition);
			this.condText.x = (stage.stageWidth/100)*5.5;
			this.condText.y = (stage.stageHeight/100)*20;
			
			}	
		
		private function printIcons():void{
			
			var valueFromWeaterCode = getWeatherCode(weatherCode); //weatherCode - returns object
			var icon = valueFromWeaterCode.icon; //String which specifies what animation to be instansiated
			
			//If datatype is not string, object contains more than one string - process loop (e.g ["Sun", "Cloud"]).
			if(typeof(valueFromWeaterCode.icon)!= "string"){

				for (var i:int = 0; i<valueFromWeaterCode.icon.length; i++){
					var ico = getIcon(valueFromWeaterCode.icon[i]);
					weatherVector.push(ico);
					super.displayObject(ico);
					// -1 for index 0
					// Adds event listener on last item in vector
					if(i == (valueFromWeaterCode.icon.length)-1){
						ico.addEventListener(Event.ADDED_TO_STAGE, positionIcons);
						}
					}
				//If only one displayObject to be rendered
				}else{
					this.weatherIcon = getIcon(icon);
					addChild(this.weatherIcon);
					this.weatherIcon.addEventListener(Event.ADDED_TO_STAGE, positionIcon);
					}
			}
			
			private function positionIcons(e:Event):void{
				
				var posY:int = 0;
				var posX:int = (stage.stageWidth/100)*70;

				for each(var weather in weatherVector){
					weather.removeEventListener(Event.ADDED_TO_STAGE, positionIcons);
					
					if(weather is Raindrop || weather is Snowflake){

						weather.x = Math.floor(Math.random()*(stage.stageWidth)) + posX;
						weather.y = Math.floor(Math.random()*(stage.stageHeight/100)*12) + (stage.stageHeight/100)*8;
						weather.addEventListener(Event.ENTER_FRAME, function(e:Event):void{
							goRainSnow(e.target as MovieClip);
							});
							
						} else {
							weather.x = (stage.stageWidth / 100)*65;
							weather.y = posY;
							}
					posY+=80;
					
					}
				
				}
			
			private function goRainSnow(weather:MovieClip){
				if(weather.stage){
					if(weather.currentFrame == weather.totalFrames){
						var posX:int = (stage.stageWidth/100)*70;
						var highX:int = (stage.stageWidth/100)*90;
						
						weather.x = Math.floor(Math.random()*(highX-posX+1)+posX)
						weather.y = Math.floor(Math.random()*(stage.stageHeight/100)*12) + (stage.stageHeight/100)*5;
						
						}
				}
				}	
				
			private function positionIcon(e:Event):void{
				this.weatherIcon.removeEventListener(Event.ADDED_TO_STAGE, positionIcon);
				this.weatherIcon.x = (stage.stageWidth/100)*55;
				this.weatherIcon.y = (stage.stageWidth/100)*8;
				
				
				}
	}
	
}
