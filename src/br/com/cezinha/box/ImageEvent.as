package br.com.cezinha.box {
	import flash.events.Event;

	/**
	 * @author Celina Uemura (cezinha@cezinha.com.br)
	 */
	public class ImageEvent extends Event {
		//  PUBLIC PROPERTIES -------------------------------------------------------------------------------------	
		public static const COMPLETE : String = "complete";
		public static const PROGRESS : String = "progress";
		
		//  PRIVATE PROPERTIES ------------------------------------------------------------------------------------
		private var _loading : Boolean;
		private var _porcento : Number; 
		
		//  CONSTRUCTOR -------------------------------------------------------------------------------------------
		public function ImageEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
		
		//  EVENT HANDLERS ----------------------------------------------------------------------------------------			
		//  GETTERS & SETTERS METHODS -----------------------------------------------------------------------------
		public function get loading():Boolean {
			return _loading;
		}
		
		public function set loading(loading:Boolean):void {
			_loading = loading;
		}
		
		public function get porcento():Number {
			return _porcento;
		}
		
		public function set porcento(porcento:Number):void {
			_porcento = porcento;
		}
	}
}
