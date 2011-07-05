package br.com.cezinha.ui {
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author imac
	 */
	public class ScrollBarButton_Up extends ScrollBarButton_Render {
		public function ScrollBarButton_Up() {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			super.init(this.getChildByName("top") as Sprite,
						this.getChildByName("middle") as Sprite,
						this.getChildByName("bottom") as Sprite);
		}
	}
}
