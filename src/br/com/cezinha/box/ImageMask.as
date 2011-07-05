package br.com.cezinha.box {
	import flash.display.Sprite;
	/**
	 * @author Celina Uemura (cezinha@cezinha.com.br)
	 */
	public class ImageMask extends Image {
		//  PUBLIC PROPERTIES -------------------------------------------------------------------------------------		
		public var mcMask:Sprite;
		//  PRIVATE PROPERTIES ------------------------------------------------------------------------------------		
			
		//  CONSTRUCTOR -------------------------------------------------------------------------------------------
		public function ImageMask() {
			super();
			
			this.mask = mcMask;
		}
		
		//  PUBLIC METHODS ----------------------------------------------------------------------------------------
		//  PRIVATE METHODS ---------------------------------------------------------------------------------------
		//  EVENT HANDLERS ----------------------------------------------------------------------------------------		
		//  GETTERS & SETTERS METHODS -----------------------------------------------------------------------------
	} 
}
