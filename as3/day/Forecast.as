package  as3.day{
	
	import as3.day.ForecastContainer;
	import as3.day.ForecastDay;
	import flash.events.Event;
	import flash.display.*;
	
	public class Forecast extends MovieClip{
		
		private var forecastArray:Array;
		private var forecastVector:Vector.<ForecastDay>;
		private var callback:Function;
		private var isDay:int;
		
		public function Forecast(arr:Array, callback, isDay) {
			this.forecastArray = arr;
			this.callback = callback;
			this.isDay = isDay;
			initForecastDays();
		}
		
		private function initForecastDays():void{
			this.forecastVector = new Vector.<ForecastDay>;
			//Start at index 1 because index 0 = current day
			for(var i:int = 1; i<forecastArray.length; i++){
				var day = new ForecastDay(this.forecastArray[i], this.isDay);
				this.forecastVector.push(day);
				this.callback(day);
				}
			
			}


	}
	
}
