package  as3.middle{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.events.Event;
	import as3.middle.CurrentExtraInfo;
	
	//
	// Class for instantiateing sunriseSunset symbol, position and print text regarding sunrise & sunset info.
	//
	
	public class SunriseSunset extends CurrentExtraInfo{
		
		private var sunriseText:TextField;
		private var sunsetText:TextField;
		private var sunriseSunsetIcon;
		
		public function SunriseSunset(data) {
			super(data);
			initSunriseTextfield();
			initSunsetTextfield();
			initSunriseSunsetIcon();
		}
		
		private function initSunriseTextfield():void{
			this.sunriseText = new TextField();
			var format:TextFormat = new TextFormat();
			var timeString:String = data.forecast.forecastday[0].astro.sunrise;
			
			format.size = FONT_SIZE;
			format.font = FONT;
			format.color = fontColor;
			
			this.sunriseText.embedFonts = true;
			this.sunriseText.text = setText(timeString);
			this.sunriseText.setTextFormat(format);
			
			addChild(this.sunriseText);
			this.sunriseText.addEventListener(Event.ADDED_TO_STAGE, positionSunriseText);
			
			}
			
		private function positionSunriseText(e:Event):void{
			
			this.sunriseText.x = (stage.stageWidth/100)*6;
			this.sunriseText.y = (stage.stageHeight/100)*TEXT_Y;
			
			}
			
			
		private function initSunsetTextfield():void{
			this.sunsetText = new TextField();
			var format:TextFormat = new TextFormat();
			var timeString:String = data.forecast.forecastday[0].astro.sunset;
			trace(timeString);
			
			format.size = FONT_SIZE;
			format.font = FONT;
			format.color = fontColor;
			
			this.sunsetText.embedFonts = true;
			
			//Converts imperial time to metric
			this.sunsetText.text = setText(timeString);			
			this.sunsetText.setTextFormat(format);
			addChild(this.sunsetText);
			
			this.sunsetText.addEventListener(Event.ADDED_TO_STAGE, positionSunsetText);
			}
			
		private function positionSunsetText(e:Event):void{
			
			this.sunsetText.x = (stage.stageWidth/100)*38;
			this.sunsetText.y = (stage.stageHeight/100)*TEXT_Y;
			
			}
			
		private function initSunriseSunsetIcon():void{
			
			day ? this.sunriseSunsetIcon = new SunriseSunsetDay() : this.sunriseSunsetIcon = new SunriseSunsetNight();
			addChild(this.sunriseSunsetIcon);
			this.sunriseSunsetIcon.addEventListener(Event.ADDED_TO_STAGE, positionSunriseIcon);
			
			}
		private function positionSunriseIcon(e:Event):void{
			
			this.sunriseSunsetIcon.scaleX = 0.5;
			this.sunriseSunsetIcon.scaleY = 0.5;
			this.sunriseSunsetIcon.x = (stage.stageWidth/100)*5.5;
			this.sunriseSunsetIcon.y = (stage.stageHeight/100)*ICON_Y;
			
			
			}
		
			
		//setText and returnMetricTimePM is used to split the string containing
		//the time of sunset and sunrise, converts the time IF containing the string "PM"
		//returnMetricTimePM returns the equivilant value, in metric time
		private function setText(timeString:String):String{
			var tf:TextField = new TextField();
			if(timeString.indexOf("AM") != -1){
				tf.text = timeString.substring(0, 5);
				}else{
					tf.text = returnMetricTimePM(timeString.substring(0,2));
					tf.appendText(timeString.substring(2,5));
					}
				return tf.text;
			
			}
			
		private function returnMetricTimePM(str:String):String{
			
			switch(str){
				
				case "01":
					return "13";
				break;
				case "02":
					return "14";
				break;
				case "03":
					return "15";
				break;
				case "04":
					return "16";
				break;
				case "05":
					return "17";
				break;
				case "06":
					return "18";
				break;
				case "07":
					return "19";
				break;
				case "08":
					return "20";
				break;
				case "09":
					return "21";
				break;
				case "10":
					return "22";
				break;
				case "11":
					return "23";
				break;
				case "12":
					return "00";
				break;
				default:
					return "--";
				
				}
			
			}
	}
	
}
