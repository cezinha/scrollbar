package {
	import br.com.cezinha.ui.ScrollBar;
	import br.com.cezinha.ui.ScrollEvent;

	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	 * @author Celina Uemura (cezinha@cezinha.com.br)
	 */
	public class Main extends MovieClip {
		public var mc : MovieClip;
		public var scroll : ScrollBar;

		public function Main() {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			scroll.setContentSize(mc.y, 500, mc.height);
			scroll.addEventListener(ScrollEvent.MOVE, onScrollMove);
		}
			
		function onScrollMove(e:ScrollEvent):void {
			mc.y = - Math.round( e.percent * (mc.height - 500));
		}
	}
}
