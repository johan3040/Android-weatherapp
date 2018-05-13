package {
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	import flash.utils.clearInterval;
	import flash.text.TextField;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.events.Event;
	
	import as3.loading.LoadingScreen;
	import as3.errorhandler.ErrorWindow;
	
	import as3.fonts.Font;
	import as3.url.Urlreq;
	
	import as3.day.MainDay;
	import as3.day.Current;
	import as3.day.Forecast;
	import as3.day.ForecastContainer;
	
	import as3.middle.CurrentExtraInfo;
	import as3.middle.Comp;
	import as3.middle.SunriseSunset;
	import flash.events.MouseEvent;
	
	public class Main extends MovieClip {
		private var _application:NativeApplication;
		private var errorWindow:ErrorWindow;
		private var url:Urlreq;
		private var current:Current;
		private var forecastArray:Array;
		private var forecast: Forecast;
		private var compass:Comp;
		private var sunriseSunset:SunriseSunset;
		private var data:*;
		private var forecastContainer:ForecastContainer;
		private var currentExtraInfo:CurrentExtraInfo;
		private var loading:LoadingScreen;
		private var background:Background;
		private var nightBg:NightBg;
		private var dayBg:DayBg;
		private var currentTimer:uint;
		private var middleTimer:uint;
		private var forecastTimer:uint;
		private var refreshBtn:RefreshBtn;
		
		public function Main():void {
			initBackground();
			initSettings();
		}
		
		private function initBackground():void{
			
			this.background = new Background();
			addChild(background);
			this.loading = new LoadingScreen();
			addChild(loading);
			initUrlReq();
			}
		
		// Forces the device to keep screen on (doesn't sleep)
		private function initSettings():void{
			
			Multitouch.inputMode=MultitouchInputMode.TOUCH_POINT;
			this._application = NativeApplication.nativeApplication;
			this._application.addEventListener(Event.ACTIVATE, activate);
			this._application.addEventListener(Event.DEACTIVATE, deactivate);
			this._application.addEventListener(Event.EXITING, exiting);
			
			}
			
		private function activate(e:Event):void{
			
			this._application.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
			
			}
			
		private function deactivate(e:Event):void{

			this._application.systemIdleMode = SystemIdleMode.NORMAL;
			
			}
			
		private function exiting(e:Event):void{

			this._application.removeEventListener(Event.ACTIVATE, activate);
			this._application.removeEventListener(Event.DEACTIVATE, deactivate);
			this._application.removeEventListener(Event.EXITING, exiting);
			this._application.systemIdleMode = SystemIdleMode.NORMAL;
			
			}
		
		private function initUrlReq():void{
			
			this.url = new Urlreq(this.returnData);
			
			}
		
		//
		// Callback function for UrlReq
		// If @return == string - create error message
		// Else JSON object is returned - handle data
		//
		private function returnData(data:*):void{
			
			if(typeof(data) == "string"){
				removeLoadingScreen();
				createErrorWindow(data);
				
				}else{
					this.data = data;
					removeLoadingScreen();
					addBackground();
					addCurrent();
					addForecastContainer();
					addCurrentExtraInfoContainer();
					addRefreshBtn();
					}
			
			}
			
		private function removeLoadingScreen():void{

			removeChild(this.loading);
			this.loading = null;
			removeChild(this.background);
			this.background = null;
			
			}
			
		private function addBackground():void{

			if(this.data.current.is_day === 0){
				this.nightBg = new NightBg();
				addChild(this.nightBg);
				}else{					
					this.dayBg = new DayBg();
					addChild(this.dayBg);
					}
			
			}
		
		private function createErrorWindow(msg:String):void{
			
			this.errorWindow = new ErrorWindow(msg, this.clearStage);
			addChild(errorWindow);
			
			}
			
		//
		// Callback function from "ErrorWindow".
		// Clears stage and calls initBackground
		//
		private function clearStage(e:TouchEvent):void{
			
			removeChild(this.errorWindow);
			initBackground();
			
			}
		
		private function addCurrent():void{
			
			this.current = new Current(this.data);
			this.current.addEventListener(Event.ADDED_TO_STAGE, fade);
			addChild(this.current);
			
			
			}
			
		private function fade(e:Event):void{
			this.current.removeEventListener(Event.ADDED_TO_STAGE, fade);
			this.current.alpha = 0;
			setTimeout(function():void{
				this.currentTimer = setInterval(fadeContent, 10);
				}, 200);
			
			}
			
		private function fadeContent():void{
			
			if (this.current.alpha < 1){
				this.current.alpha+= 0.02;
				}else {
					clearInterval(this.currentTimer);
					}
			
			}
			
		private function addForecastContainer():void{
			this.forecastContainer 	= new ForecastContainer();
			this.forecastContainer.addEventListener(Event.ADDED_TO_STAGE, fadeForecast);
			addChild(this.forecastContainer);
			
			this.forecastArray 		= this.data.forecast.forecastday;
			this.forecast			= new Forecast(this.forecastArray, this.returnForecastDay, this.data.current.is_day);
			
			}
			
		private function fadeForecast(e:Event){
			this.forecastContainer.removeEventListener(Event.ADDED_TO_STAGE, fadeForecast);
			this.forecastContainer.alpha = 0;
			setTimeout(function():void{
				this.forecastTimer = setInterval(ff, 10);
				}, 800);			
			}
		
		//
		// Fade function for forecastContainer
		//
		private function ff():void{
			
			if (this.forecastContainer.alpha < 1){
				this.forecastContainer.alpha += 0.02;
				}else {
					clearInterval(this.forecastTimer);
					}
			
			}
			
		private function returnForecastDay(obj):void{
			
			this.forecastContainer.addChild(obj);
			// For each time a child is added, the container is centered
			this.forecastContainer.x = stage.stageWidth*0.5 - this.forecastContainer.width*0.5;
			this.forecastContainer.y = (stage.stageHeight/100)*70;
			
			}
			
		private function addCurrentExtraInfoContainer():void{
			
			this.currentExtraInfo = new CurrentExtraInfo(this.data);
			this.currentExtraInfo.addEventListener(Event.ADDED_TO_STAGE, fadeExtraInfo);
			addChild(this.currentExtraInfo);
			addCompass();
			addSunriseSunset();
			}
			
		private function fadeExtraInfo(e:Event):void{
			this.currentExtraInfo.removeEventListener(Event.ADDED_TO_STAGE, fadeExtraInfo);
			this.currentExtraInfo.alpha = 0;
			setTimeout(function():void{
				this.middleTimer = setInterval(fxi, 10);
				}, 500);
			
			}
		
		//
		// Fade function for currentExtraInfo
		//
		private function fxi():void{

			if (this.currentExtraInfo.alpha < 1){
				this.currentExtraInfo.alpha+= 0.02;
				}else {
					clearInterval(this.middleTimer);
					}
			
			}
			
		private function addCompass():void{
			
			this.compass = new Comp(this.data);
			this.currentExtraInfo.addChild(this.compass);
			
			}
			
		private function addSunriseSunset():void{
			
			this.sunriseSunset = new SunriseSunset(this.data);
			this.currentExtraInfo.addChild(this.sunriseSunset);
			}
			
		private function addRefreshBtn():void{
			
			this.refreshBtn = new RefreshBtn();
			this.refreshBtn.addEventListener(Event.ADDED_TO_STAGE, positionRefreshBtn);
			
			addChild(this.refreshBtn);
			}
			
		private function positionRefreshBtn(e:Event):void{
			this.refreshBtn.x = (stage.stageWidth/100)*88;
			this.refreshBtn.y = (stage.stageHeight/100)*95;
			this.refreshBtn.addEventListener(TouchEvent.TOUCH_TAP, refresh);
			}
			
		private function refresh(e:TouchEvent):void{
			removeChild(this.current);
			removeChild(this.forecastContainer);
			removeChild(this.currentExtraInfo);
			removeChild(this.refreshBtn);
			initBackground();
			
			
			}
	}
	
}
