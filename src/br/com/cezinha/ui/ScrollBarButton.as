package br.com.cezinha.ui {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * @author imac
	 */
	public class ScrollBarButton extends MovieClip {
		public var barUp: ScrollBarButton_Up;
		public var barOver: ScrollBarButton_Over;
		
		public function ScrollBarButton() {			
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			//addEventListener(MouseEvent.MOUSE_OVER, onOver);
			//addEventListener(MouseEvent.MOUSE_OUT, onOut);
			
			barOver.visible = false;
			barUp.visible = true;
		}
		
		public function onOver(event : MouseEvent = null) : void {
			barOver.visible = true;
			barUp.visible = false;
		}
		
		public function onOut(event : MouseEvent = null) : void {
			barOver.visible = false;
			barUp.visible = true;
		}

		public function setHeight(value:Number):void {
			barUp.setHeight(value);
			barOver.setHeight(value);
		}
	}
}
