package br.com.cezinha.box {
	import flash.display.Sprite;

	/**
	 * @author Celina Uemura (cezinha@cezinha.com.br)
	 */
	
	public class LoadingBarBase extends BaseBox {

		//  PUBLIC PROPERTIES -------------------------------------------------------------------------------------	
		//  PRIVATE PROPERTIES ------------------------------------------------------------------------------------		
		private var _barra:Sprite;

		//  CONSTRUCTOR -------------------------------------------------------------------------------------------
		public function LoadingBarBase() {
		}
		
		public function init(barra:Sprite):void {
			_barra = barra;
			_barra.scaleX = 0;
		}
		//  PUBLIC METHODS ----------------------------------------------------------------------------------------
		public function update(porcento:Number):void {
			if (_barra != null) {
				if (porcento < 1) {
					_barra.scaleX = porcento;
				} else {
					this.hide();
				}
			}
		}
		//  PRIVATE METHODS ---------------------------------------------------------------------------------------

		//  EVENT HANDLERS ----------------------------------------------------------------------------------------		
		//  GETTERS & SETTERS METHODS -----------------------------------------------------------------------------
	}
}