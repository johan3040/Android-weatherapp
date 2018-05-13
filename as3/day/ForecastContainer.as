package  as3.day{
	
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	
	public class ForecastContainer extends Sprite{
		
		
		public function ForecastContainer() {
			
			//constructor
			
		}

		public override function addChild(child:DisplayObject):DisplayObject{
			
			if(numChildren >0){
				
				var lastIndex:DisplayObject = getChildAt(numChildren-1);
				var pos:Number = lastIndex.x + lastIndex.width;
				child.x = pos;
			}
			
			super.addChild(child);
			return child;
			}
	}
	
}
