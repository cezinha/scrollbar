package br.com.cezinha.ui {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	/**
	 * @author cuemura
	 */
	public class BotaoNavegacao extends MovieClip {
		//  PUBLIC PROPERTIES -------------------------------------------------------------------------------------		
		public var clicked:Boolean;

		//  PRIVATE PROPERTIES ------------------------------------------------------------------------------------
		private var _index:uint;
		
		//  CONSTRUCTOR -------------------------------------------------------------------------------------------
		public function BotaoNavegacao() {
			stop();
			
			enable();
			
			clicked = false;
		}

		//  PUBLIC METHODS ----------------------------------------------------------------------------------------
		public function release():void {
			clicked = false;
			hide();
		}
		
		public function activate():void {
			clicked = true;
			show();		
		}	

		public function hide():void {
			this.gotoAndStop(1);
		}
		
		public function show():void {
			this.gotoAndStop(2);
		}
		
		public function disable():void {
			this.enabled = false;
			this.buttonMode = false;
			this.mouseEnabled = false;
			this.removeEventListener(MouseEvent.ROLL_OVER, onOverHandler);
			this.removeEventListener(MouseEvent.ROLL_OUT, onOutHandler);
			this.removeEventListener(MouseEvent.MOUSE_UP, onReleaseHandler);
		}
		
		public function enable():void {
			this.enabled = true;
			this.buttonMode = true;
			this.mouseEnabled = true;
			this.addEventListener(MouseEvent.ROLL_OVER, onOverHandler);
			this.addEventListener(MouseEvent.ROLL_OUT, onOutHandler);
			this.addEventListener(MouseEvent.MOUSE_UP, onReleaseHandler);
		}

		//  PRIVATE METHODS ---------------------------------------------------------------------------------------

		//  EVENT HANDLERS ----------------------------------------------------------------------------------------	
		protected function onOverHandler(m:MouseEvent):void {
			if (!clicked) {
				show();
			}	
		}
		
		protected function onOutHandler(m:MouseEvent):void {
			if (!clicked) {
				hide();
			}
		}
		
		private function onReleaseHandler(m:MouseEvent):void {
			activate();
		}
				
		//  GETTERS & SETTERS METHODS -----------------------------------------------------------------------------
		public function get index():uint {
			return _index;
		}
		
		public function set index(idx:uint) : void {
			_index = idx;
		}
	}
}
