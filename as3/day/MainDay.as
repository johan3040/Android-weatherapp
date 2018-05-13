package  as3.day{
	
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import as3.fonts.Font;
	
	
	//
	// Superclass for 'ForecastDay' and 'Current'
	// Sets common variables
	//
	
	public class MainDay extends MovieClip {
		
		protected var deg:int;
		protected var weekday:String;
		protected var weatherCode:int;
		protected var fontColor:uint;
		protected var isDay:Boolean;
		protected const FONT: String = "MontserratLight";
		
		public function MainDay() {
			//Constructor
			
		}
		
		protected function isItDay(val:Number):void{
			val === 0 ? this.fontColor = 0xFFFFFF : this.fontColor = 0x000000;
			}
		
		protected function getDate(date_epoch:Number):String{
			
			
			var newDate = new Date();
			newDate.time = date_epoch;
			var dateString = newDate.toString();
			return dateString.substring(0,3);
			}
		
		//
		// Function for returning object containing strings with icon names
		// and weather description
		// @return Object
		//
		protected function getWeatherCode(number:int):Object{
			var obj:Object = new Object();
			switch(number){
				
				//Icons
				//*Sun
				//*Cloud
				//*Rain
				//*Snow
				//*Fog
				//*Lightning
				
				case 1000:
					obj = {
								"code" : 1000,
								"day" : "Sunny",
								"night" : "Clear",
								"icon" : "Sun"
							};
					break;
				case 1003:
					 obj = {
								"code" : 1003,
								"day" : "Partly cloudy",
								"night" : "Partly cloudy",
								"icon" : ["Sun","Cloud"]
							};
					break;
				case 1006:
					obj = {
							"code" : 1006,
							"day" : "Cloudy",
							"night" : "Cloudy",
							"icon" : "Cloud"
						};
					break;
				case 1009:
					obj ={
							"code" : 1009,
							"day" : "Overcast",
							"night" : "Overcast",
							"icon" : "Cloud"
						};
					break;
				case 1030:
					obj = {
							"code" : 1030,
							"day" : "Mist",
							"night" : "Mist",
							"icon" : "Fog"
						};
					break;
				case 1063:
					obj = {
							"code" : 1063,
							"day" : "Patchy rain possible",
							"night" : "Patchy rain possible",
							"icon" : ["Cloud", "Rain"]
						};
					break;
				case 1066:
					obj = {
							"code" : 1066,
							"day" : "Patchy snow possible",
							"night" : "Patchy snow possible",
							"icon" : ["Cloud","Snow"]
						};
					break;
				case 1069:
					obj = {
							"code" : 1069,
							"day" : "Patchy sleet possible",
							"night" : "Patchy sleet possible",
							"icon" : ["Cloud", "Snow"]
						};
					break;
				case 1072:
					obj = {
							"code" : 1072,
							"day" : "Patchy freezing drizzle possible",
							"night" : "Patchy freezing drizzle possible",
							"icon" : ["Cloud", "Snow"]
						};
					break;
				case 1087:
					obj = {
							"code" : 1087,
							"day" : "Thundery outbreaks possible",
							"night" : "Thundery outbreaks possible",
							"icon" : ["Cloud", "Lightning"]
						};
					break;
				case 1114:
					obj = {
							"code" : 1114,
							"day" : "Blowing snow",
							"night" : "Blowing snow",
							"icon" : ["Cloud","Snow"]
						};
					break;
				case 1117:
					obj = {
							"code" : 1117,
							"day" : "Blizzard",
							"night" : "Blizzard",
							"icon" : ["Cloud", "Snow", "Snow", "Snow", "Snow"]
						};
					break;
				case 1135:
					obj = {
							"code" : 1135,
							"day" : "Fog",
							"night" : "Fog",
							"icon" : "Fog"
						};
					break;
				case 1147:
					obj = {
							"code" : 1147,
							"day" : "Freezing fog",
							"night" : "Freezing fog",
							"icon" : "Fog"
						};
					break;
				case 1150:
					obj = {
							"code" : 1150,
							"day" : "Patchy light drizzle",
							"night" : "Patchy light drizzle",
							"icon" : ["Cloud", "Rain"]
						};
					break;
				case 1153:
					obj = {
							"code" : 1153,
							"day" : "Light drizzle",
							"night" : "Light drizzle",
							"icon" : ["Cloud", "Rain"]
						};
					break;
				case 1168:
					obj = {
							"code" : 1168,
							"day" : "Freezing drizzle",
							"night" : "Freezing drizzle",
							"icon" : ["Cloud","Rain"]
						};
					break;
				case 1171:
					obj = {
							"code" : 1171,
							"day" : "Heavy freezing drizzle",
							"night" : "Heavy freezing drizzle",
							"icon" : ["Cloud", "Rain", "Snow", "Rain", "Snow"]
						};
					break;
				case 1180:
					obj = {
							"code" : 1180,
							"day" : "Patchy light rain",
							"night" : "Patchy light rain",
							"icon" : ["Cloud", "Rain"]
						};
					break;
				case 1183:
						obj = {
							"code" : 1183,
							"day" : "Light rain",
							"night" : "Light rain",
							"icon" : ["Cloud", "Rain"]
						};
					break;
				case 1186:
					obj = {
							"code" : 1186,
							"day" : "Moderate rain at times",
							"night" : "Moderate rain at times",
							"icon" : ["Cloud", "Rain", "Rain"]
						};
					break;
				case 1189:
					obj = {
							"code" : 1189,
							"day" : "Moderate rain",
							"night" : "Moderate rain",
							"icon" : ["Cloud", "Rain", "Rain"]
						};
					break;
				case 1192:
					obj = {
							"code" : 1192,
							"day" : "Heavy rain at times",
							"night" : "Heavy rain at times",
							"icon" : ["Cloud", "Rain", "Rain", "Rain", "Rain"]
						};
					break;
				case 1195:
					obj = {
							"code" : 1195,
							"day" : "Heavy rain",
							"night" : "Heavy rain",
							"icon" : ["Cloud", "Rain", "Rain", "Rain", "Rain"]
						};
					break;
				case 1198:
					obj = {
							"code" : 1198,
							"day" : "Light freezing rain",
							"night" : "Light freezing rain",
							"icon" : ["Cloud", "Rain", "Snow"]
						};
					break;
				case 1201:
					obj = {
							"code" : 1201,
							"day" : "Moderate or heavy freezing rain",
							"night" : "Moderate or heavy freezing rain",
							"icon" : ["Cloud", "Rain", "Snow", "Rain"]
						};
					break;
				case 1204:
					obj = {
							"code" : 1204,
							"day" : "Light sleet",
							"night" : "Light sleet",
							"icon" : ["Cloud", "Rain"]
						};
					break;
				case 1207:
					obj = {
							"code" : 1207,
							"day" : "Moderate or heavy sleet",
							"night" : "Moderate or heavy sleet",
							"icon" : ["Cloud", "Rain", "Snow", "Rain"]
						};
					break;
				case 1210:
					obj = {
							"code" : 1210,
							"day" : "Patchy light snow",
							"night" : "Patchy light snow",
							"icon" : ["Cloud","Snow", "Snow"]
						};
					break;
				case 1213:
					obj = {
							"code" : 1213,
							"day" : "Light snow",
							"night" : "Light snow",
							"icon" : ["Cloud", "Snow"]
						};
					break;
				case 1216:
					obj = {
							"code" : 1216,
							"day" : "Patchy moderate snow",
							"night" : "Patchy moderate snow",
							"icon" : ["Cloud", "Snow"]
						};
					break;
				case 1219:
					obj = {
							"code" : 1219,
							"day" : "Moderate snow",
							"night" : "Moderate snow",
							"icon" : ["Cloud", "Snow", "Snow"]
						};
					break;
				case 1222:
					obj = {
							"code" : 1222,
							"day" : "Patchy heavy snow",
							"night" : "Patchy heavy snow",
							"icon" : ["Cloud", "Snow", "Snow", "Snow", "Snow"]
						};
					break;
				case 1225:
					obj = {
							"code" : 1225,
							"day" : "Heavy snow",
							"night" : "Heavy snow",
							"icon" : ["Cloud", "Snow", "Snow", "Snow", "Snow"]
						};
					break;
				case 1237:
					obj = {
							"code" : 1237,
							"day" : "Ice pellets",
							"night" : "Ice pellets",
							"icon" : ["Cloud", "Snow"]
						};
					break;
				case 1240:
					obj = {
							"code" : 1240,
							"day" : "Light rain shower",
							"night" : "Light rain shower",
							"icon" : ["Cloud", "Rain", "Rain"]
						};
					break;
				case 1243:
					obj = {
							"code" : 1243,
							"day" : "Moderate or heavy rain shower",
							"night" : "Moderate or heavy rain shower",
							"icon" : ["Cloud", "Rain", "Rain", "Rain"]
						};
					break;
				case 1246:
					obj = {
							"code" : 1246,
							"day" : "Torrential rain shower",
							"night" : "Torrential rain shower",
							"icon" : ["Cloud", "Rain", "Rain"]
						};
					break;
				case 1249:
					obj = {
							"code" : 1249,
							"day" : "Light sleet showers",
							"night" : "Light sleet showers",
							"icon" : ["Cloud", "Rain", "Snow", "Snow"]
						};
					break;
				case 1252:
					obj = {
							"code" : 1252,
							"day" : "Moderate or heavy sleet showers",
							"night" : "Moderate or heavy sleet showers",
							"icon" : ["Cloud", "Snow", "Snow", "Rain"]
						};
					break;
				case 1255:
					obj = {
							"code" : 1255,
							"day" : "Light snow showers",
							"night" : "Light snow showers",
							"icon" : ["Cloud", "Rain", "Snow"]
						};
					break;
				case 1258:
					obj = {
							"code" : 1258,
							"day" : "Moderate or heavy snow showers",
							"night" : "Moderate or heavy snow showers",
							"icon" : ["Cloud", "Snow", "Snow", "Rain", "Rain"]
						};
					break;
				case 1261:
					obj = {
							"code" : 1261,
							"day" : "Light showers of ice pellets",
							"night" : "Light showers of ice pellets",
							"icon" : ["Cloud", "Snow", "Rain"]
						};
					break;
				case 1264:
					obj = {
							"code" : 1264,
							"day" : "Moderate or heavy showers of ice pellets",
							"night" : "Moderate or heavy showers of ice pellets",
							"icon" : ["Cloud", "Snow", "Snow"]
						};
					break;
				case 1273:
					obj = {
							"code" : 1273,
							"day" : "Patchy light rain with thunder",
							"night" : "Patchy light rain with thunder",
							"icon" : ["Cloud", "Lightning", "Rain"]
						};
					break;
				case 1276:
					obj = {
							"code" : 1276,
							"day" : "Moderate or heavy rain with thunder",
							"night" : "Moderate or heavy rain with thunder",
							"icon" : ["Cloud", "Lightning", "Rain", "Rain"]
						};
					break;
				case 1279:
					obj = {
							"code" : 1279,
							"day" : "Patchy light snow with thunder",
							"night" : "Patchy light snow with thunder",
							"icon" : ["Cloud", "Lightning", "Snow"]
						};
					break;
				case 1282:
					obj = {
							"code" : 1282,
							"day" : "Moderate or heavy snow with thunder",
							"night" : "Moderate or heavy snow with thunder",
							"icon" : ["Cloud", "Lightning", "Snow", "Snow"]
						};
					break;
				default:
					obj = {};
				}
				
				return obj;
		}
		
		//
		// Function for instantiating new movieclips.
		// Called by subclasses 'ForecastDay' and 'Current'
		//
		protected function getIcon(weather:String):MovieClip{
		
			var animation:MovieClip;
			switch(weather){
				
				case "Sun":
					animation = new Sun();
					break;
				case "Rain":
					animation = new Raindrop();
					break;
				case "Cloud":
					animation = new Cloud();
					break;
				case "Snow":
					animation = new Snowflake();
					break;
				case "Fog":
					animation = new Fog();
					break;
				case "Lightning":
					animation = new Lightning();
					break;
				default:
					animation = new Cloud();
					break;
				}
				
				return animation;
					
			}
		
		//
		// Function for adding objects at correct indexes.
		// Snowflake and Raindrop adds to back.
		//
		protected function displayObject(ico:DisplayObject):void{

		//If object is 'Raindrop' or 'Snowflake
			//add to back (behind cloud)
			if(ico is Raindrop || ico is Snowflake){
				addChildAt(ico,0);
				}else{
					addChild(ico);
					}
		}
			
	}
	
	
}
