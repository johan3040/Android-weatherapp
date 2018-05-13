package  as3.day{
	
	import as3.day.MainDay;
	import as3.day.ForecastContainer;
	
	import flash.events.Event;
	import flash.display.*;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	
	//
	// Class for creating and positioning new forecastdays.
	//
	
	public class ForecastDay extends MainDay {
		
		private const FORECAST_SIZE:int = 24;
		private var dayText:TextField;
		private var obj:Object;	
		
		public function ForecastDay(obj:Object, isDay) {
			
			this.isItDay(isDay);
			
			this.obj = obj;
			initInfo();
			createVisibleDeg();
			createIcons();
		}
		
		private function initInfo():void{
			
			deg = this.obj.day.avgtemp_c;
			weatherCode = this.obj.day.condition.code;
			
			weekday = getDate(this.obj.date_epoch*1000);
			createVisibleDayText();
			}
		
		private function addedToStage(e:Event):void{
			var line:Sprite = new Sprite();
			line.graphics.beginFill(0x000000);
			line.graphics.drawRect(0, 0, 1, (stage.stageHeight/100)*20);
			line.graphics.endFill();
			addChild(line);
			}
		
		private function createVisibleDayText():void{
			
			dayText = new TextField();
			var format:TextFormat = new TextFormat();
			format.size = this.FORECAST_SIZE;
			format.font = FONT;
			format.color = fontColor;
			
			dayText.width = 68;
			dayText.embedFonts = true;
			dayText.text = weekday;
			dayText.x = 15;
			dayText.setTextFormat(format);
			addChild(dayText);
			
			}
			
		private function createVisibleDeg():void{
			
			var textfield:TextField = new TextField();
			var format:TextFormat = new TextFormat();
			format.size = this.FORECAST_SIZE;
			format.font = FONT;
			format.color = fontColor;
			
			textfield.y = 50;
			textfield.width = 68;
			textfield.x = 15;
			textfield.embedFonts = true;
			textfield.text = deg.toString();
			textfield.setTextFormat(format);
			
			addChild(textfield);
		}
		
		private function createIcons():void{
			
			var wc = getWeatherCode(weatherCode);
			
			if(typeof(wc.icon) !== "string"){
				if(wc.icon.length === 2){
					placeTwo(wc.icon);
					}else{
						
						for (var i:int = 0; i<wc.icon.length; i++){
							var ico = getIcon(wc.icon[i]);
							ico.scaleX = 0.2;
							ico.scaleY = 0.2;
							ico.y = 120 - (ico.height/2);
							ico.x = 30-ico.width/2;
							super.displayObject(ico);
							if(ico is Snowflake || ico is Raindrop){
								ico.addEventListener(Event.ENTER_FRAME, function(e:Event):void{
									goRainSnow(e.target as MovieClip);
								});
								}
							}
						}
				
				}else{
					addSolo(wc.icon);
					}
			
			}
			
		private function addSolo(wc:String):void{
			
			var solo = getIcon(wc);
			solo.scaleX = 0.2;
			solo.scaleY = 0.2;
			solo.y = 120 - (solo.height/2);
			solo.x = 30-solo.width/2;
			addChild(solo);
			
			}
		
		private function placeTwo(arr:Array):void{
			var margin:int = 8;
			
			for(var i:int; i<arr.length; i++){
				
				var ico = getIcon(arr[i]);
				ico.scaleX = 0.2;
				ico.scaleY = 0.2;
				ico.x = 30-ico.width/2;

				i === 0 ? ico.y = 120 - (ico.height/2) : ico.y = 120 - (ico.height/2) + margin;
				
				super.displayObject(ico);
				}
			
			}
		
		private function goRainSnow(weather:MovieClip):void{
			if(weather.stage){

				if(weather.currentFrame == weather.totalFrames){
						var posX:int = (stage.stageWidth/100)*70;
						var highX:int = (stage.stageWidth/100)*90;
						
						weather.x = Math.floor(Math.random()*30) + 13;
						weather.y = 130 - (weather.height/2);
						
						}
				}
			
			}
			
			
	}
	
}
