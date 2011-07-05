package br.com.cezinha.box {
	import flash.events.Event;
	import flash.display.Sprite;

	/**
	 * @author Celina Uemura (cezinha@cezinha.com.br)
	 */
	public class LoadingBar extends LoadingBarBase {
		public function LoadingBar() {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			super.init(this["barra"] as Sprite);
		}
	}
}
