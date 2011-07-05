package br.com.cezinha.ui {
	import com.greensock.TweenMax;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * @author cuemura
	 */
	public class MenuNavegacao extends MovieClip {
		//  PUBLIC PROPERTIES -------------------------------------------------------------------------------------		
		public var btns:Array = [];
						
		//  PRIVATE PROPERTIES ------------------------------------------------------------------------------------		
		private var _selected:Number;
		protected var initialized:Boolean;
		
		//  CONSTRUCTOR -------------------------------------------------------------------------------------------
		public function MenuNavegacao() {
			_selected = -1;
			initialized = false;
		}
		
		//  PUBLIC METHODS ----------------------------------------------------------------------------------------
		public function init(n:Number):void {
			if (!initialized) {	
				
				for (var i:uint = 1; i < n + 1; i++) {
					 var btn:BotaoNavegacao = this.getChildByName("btn"+i) as BotaoNavegacao;
					 btn.addEventListener(MouseEvent.MOUSE_UP, btnReleaseHandler); 
					 btn.index = i - 1;
					 btns.push(btn);
				}
				initialized = true;
			}
		}	
		
		public function reset():void {
			for (var i:uint = 0; i < btns.length; i++) {
				if ((i != _selected) && (btns[i].height > 0)) {
					btns[i].release();
				}				
			}
		}
		
		public function activate(n:Number):void {
			_selected = n;
			if (_selected > -1) btns[_selected].activate();
			reset();
			
			for (var i:uint = 0; i < btns.length; i++) {
				if (btns[i].height > 0) {
					var btn:BotaoNavegacao = btns[i] as BotaoNavegacao;
					if (btn.enabled && (btn.alpha != 1)) {
						TweenMax.to(btn, 0.4, {alpha:1});					
					}
				}
			}
			
			dispatchEvent(new Event(Event.CHANGE));
		}

		public function enable():void {
			this.mouseChildren = true;
		}
		
		public function disable():void {
			this.mouseChildren = false;
		}
		
		//  PRIVATE METHODS ---------------------------------------------------------------------------------------

		//  EVENT HANDLERS ----------------------------------------------------------------------------------------		
		protected function btnReleaseHandler(m:MouseEvent):void {
			activate(m.currentTarget.index);			
		}		
		
		//  GETTERS & SETTERS METHODS -----------------------------------------------------------------------------
		public function get selected():uint {
			return _selected;
		}
	}
}
