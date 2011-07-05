package br.com.cezinha.ui {
	import flash.events.Event;

	/**
	 * @author imac
	 */
	public class ScrollEvent extends Event {
		public var percent:Number;
		public static const MOVE : String = "MOVE";
		public static const MOVE_EASE : String = "MOVE_EASE";
		public static const STOP : String = "STOP";

		public function ScrollEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}
