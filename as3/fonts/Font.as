package  as3.fonts{
	
	public class Font {

		public function Font() {
			[Embed(source="../fonts/Montserrat-Light.ttf",
					fontName = "MontserratLight",
					mimeType = "application/x-font",
					advancedAntiAliasing="true",
					embedAsCFF="false")]
			
			var myEmbeddedFont:Class;
		}

	}
	
}
