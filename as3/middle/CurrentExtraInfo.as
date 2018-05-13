package  as3.middle{
	
	import flash.display.Sprite;
	
	//
	// Superclass of "SunriseSunset" & "Comp"
	//
	// Sets common variables
	//
	// isDay sets fontColor, dependent on value from API request
	
	public class CurrentExtraInfo extends Sprite{
		protected const FONT:String = "MontserratLight";
		protected const FONT_SIZE:int = 20;
		protected const ICON_Y:int 	= 49;
		protected const TEXT_Y:int	= 39;
		
		protected var day:Boolean;
		protected var fontColor:uint;
		protected var data:Object;
		
		public function CurrentExtraInfo(data:Object) {
			
			this.data = data;
			isDay(data.current.is_day);
		}
		
		//
		// If true - sets value to white - else black
		//
		private function isDay(val):void{
			
			val === 0 ? this.fontColor = 0xFFFFFF : this.fontColor = 0x000000;
			val === 0 ? this.day = false : this.day = true;
			
			}

	}
	
}
