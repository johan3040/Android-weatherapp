package as3.url {
	
	import flash.net.*;
	import flash.events.Event;
	import flash.sensors.Geolocation;
	import flash.events.GeolocationEvent;
	import flash.events.IOErrorEvent;
	
	import as3.errorhandler.ErrorWindow;
	
	//
	// Class for making API request
	//
	// @return JSON package OR string with error message
	//
	
	public class Urlreq{
		
		private var urlString:String;
		private var request:URLRequest;
		private var loader:URLLoader;
		private var callback:Function;
		private var geo:Geolocation;
		private var lat:Number;
		private var lng:Number;
		
		public function Urlreq(callback:Function) {
			this.callback = callback;
			geolocation();
		}
		
		public function geolocation():void{
			
			if(Geolocation.isSupported){
				this.geo = new Geolocation();
				
				if(this.geo.muted === true){
					this.callback("It seems you have \nyour geolocation \ndisabled. \nPlease turn on \nGPS and restart \napplication.");
				}else{
					this.geo.setRequestedUpdateInterval(10);
					this.geo.addEventListener(GeolocationEvent.UPDATE, func);
					}
				}
			}
			
		private function func(e:GeolocationEvent){
			this.lat = e.latitude;
			this.lng = e.longitude;
			this.geo.removeEventListener(GeolocationEvent.UPDATE, func);
			initRequest();
			}
		
		private function initRequest():void{
			this.urlString = "https://api.apixu.com/v1/forecast.json?key=26101b12e6cf4be58c6162230182701&q="+this.lat+","+this.lng+"&days=6&lang=sv";
			this.request = new URLRequest(this.urlString);
			this.loader = new URLLoader();
			this.loader.load(this.request);
			this.loader.addEventListener(Event.COMPLETE, compFunction);
			this.loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			
			}
			
		private function compFunction(e:Event):void{
			
			var data = JSON.parse(this.loader.data);
			this.callback(data);
			loader.removeEventListener(Event.COMPLETE, compFunction);
			
			}
			
		private function ioErrorHandler(e:IOErrorEvent):void{
			
			this.loader.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			this.callback("Could not find \nyour location.\nPlease try again.");
			
			}

	}
	
}