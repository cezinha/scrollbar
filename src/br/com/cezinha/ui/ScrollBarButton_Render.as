package br.com.cezinha.ui {
	import flash.display.Sprite;

	/**
	 * @author imac
	 */
	public class ScrollBarButton_Render extends Sprite {
		private var _top : Sprite;
		private var _middle : Sprite;
		private var _bottom : Sprite;
		
		public function ScrollBarButton_Render() {
		}
		
		public function init(top:Sprite, middle:Sprite, bottom:Sprite):void {
			_top = top;
			_middle = middle;
			_bottom = bottom;
		}
		
		public function setHeight(value:Number):void {
			this.scaleX = this.scaleY = 1;
			_top.y = 0;
			_middle.y = 10;
			_middle.height = value - 20;
			_bottom.y = _middle.y + _middle.height;			
		}
	}
}
