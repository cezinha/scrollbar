package br.com.cezinha.ui {
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;

	/*
	 * @author Celina Uemura (cezinha@cezinha.com.br)
	*/
	public class ScrollBar extends Sprite{
		// PUBLIC PROPERTIES
		// Assets no Stage
		public var btnUp : SimpleButton;
		public var btnDw : SimpleButton;
		public var btnBar : ScrollBarButton;
		public var bg : Sprite;
		
		// PRIVATE PROPERTIES
		private var _contentY : Number; // posição y do content
		private var _contentScrollY : Number; // posição do content de acordo com a posição do scroll
		private var _contentScrollH : Number; // altura da área visível do content
		private var _contentMaxH : Number; // altura máxima do content
		
		private var _barH : Number;
		private var _bgH : Number;
		
		private var _enabled : Boolean;
		private var _isDragging : Boolean;
		private var _mouseIsDown : Boolean;
		
		// CONSTRUCTOR
		public function ScrollBar() {
			_enabled = false;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			btnUp.visible = false;
			btnDw.visible = false;
			btnBar.visible = false;
			bg.visible = false;
			
			_isDragging = false;
			_mouseIsDown = false;
		}

		// PUBLIC FUNCTIONS
		public function setContentSize(y:Number, h:Number, maxH:Number) : void {
			_contentY = y;
			_contentScrollH = h;
			_contentMaxH = maxH;
			addListeners();
			trace(_contentScrollH < _contentMaxH);
			if (_contentScrollH < _contentMaxH) {
				startScroll();
			}
		}
		public function destroy() : void {
			removeListeners();
		}
		
		// EVENT LISTENERS
		private function mouseDown(event : MouseEvent) : void {
			var rect : Rectangle = new Rectangle(btnBar.x, bg.y, 0, _bgH - _barH);
			btnBar.startDrag(false, rect);
			
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			stage.addEventListener(Event.ENTER_FRAME, updatePosition);
			
			btnBar.onOver();
			_mouseIsDown = true;
			_isDragging = true;
		}
		
		private function updatePosition(event : Event = null) : void {
			var percent:Number = (btnBar.y - bg.y) / (_bgH - _barH);
			
			moveScroll(percent);
		}
		
		private function mouseUp(event : MouseEvent = null) : void {
			if (_mouseIsDown) {
				_mouseIsDown = false;
	
				btnBar.onOut();
				btnBar.stopDrag();
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
				stage.removeEventListener(Event.ENTER_FRAME, updatePosition);
				
				var percent : Number = (btnBar.y - bg.y) / (_bgH - _barH);
				
				if (_isDragging) {
					var evt : ScrollEvent = new ScrollEvent(ScrollEvent.MOVE);
					evt.percent = percent;
					dispatchEvent(evt);
					_isDragging = false;
				}
			}
		}
		
		private function mouseMove(m : MouseEvent):void {
			if (!m.buttonDown) {
				mouseUp();
			}
		}
		
		private function onBgDown(event : MouseEvent) : void {
			// verificar se clicou acima ou abaixo
			// verificar distância do scroll 
			// se maior que a altura do btnBar, mover 1 altura do btnBar
			// se menor, mover até o fim (ou início)
			//moveEaseScroll(posY);
			if (mouseY > btnBar.y) {
				pgDw();
			} else {
				pgUp();
			}
		}
		
		private function pgUp():void {
			var check:Number = btnBar.y - bg.y;
			
			if (check > _barH) {
				btnBar.y = btnBar.y - _barH;
				updatePosition();
			} else {
				moveToUp();
			}
		}
		
		private function pgDw():void {
			var check:Number = (bg.y + _bgH) - (btnBar.y + _barH); 
			
			if (check > _barH) {
				btnBar.y = btnBar.y + _barH;
				updatePosition();
			} else {
				moveToEnd();
			}
			
		}
		private function onUpRelease(event : MouseEvent = null) : void {
			// verificar se pode subir a barra e mover a barra, dispatch event
			var check:Number = btnBar.y - 3;
			
			if (check > bg.y) {
				btnBar.y = btnBar.y - 3;
				updatePosition();
			} else {
				moveToUp();
			}
		}
		
		private function onDwRelease(event : MouseEvent = null) : void {
			// verificar se pode descer a barra e mover a barra, dispatch event
			var check:Number = btnBar.y + _barH;
			 
			if (check < bg.y + _bgH) {
				btnBar.y = btnBar.y + 3;
				updatePosition();
			} else {
				moveToEnd();
			}
		}
		
		public function moveToUp() : void {
			btnBar.y = bg.y;
			updatePosition();
		}

		public function moveToEnd() : void {
			btnBar.y = bg.y + bg.height - _barH;
			updatePosition();
		}

		/*private function onMouseWheelEvent(event : MouseEvent) : void {
			// The delta property is the amount and direction that the mouse wheel was
			// moved up or down. If the delta is a positive integer then the mouse wheel
			// was moved up, if negative it was moved down. 
			// http://drawlogic.com/2007/05/13/mousewheel-event-in-as3/
			trace(event.delta);
		}*/
		
		private function onKeyRelease (event : KeyboardEvent) : void {
			switch (event.keyCode) {
				case Keyboard.HOME:
					moveToUp();	
					break;				
				case Keyboard.END:
					moveToEnd();
					break;					
				case Keyboard.UP:
					onUpRelease();
					break;				
				case Keyboard.DOWN:
					onDwRelease();
					break;					
				case Keyboard.PAGE_UP:
					pgUp();
					break;					
				case Keyboard.PAGE_DOWN:
					pgDw();
					break;
			}
		} 
		
		// PRIVATE FUNCTIONS
		private function addListeners() : void {
			btnBar.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			btnUp.addEventListener(MouseEvent.MOUSE_UP, onUpRelease);
			btnDw.addEventListener(MouseEvent.MOUSE_UP, onDwRelease);
			bg.addEventListener(MouseEvent.MOUSE_DOWN, onBgDown);
			
			// adiciona listener para mouse wheel
			//stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheelEvent);
			// adiciona listener para teclas
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyRelease); 
		}
		private function removeListeners() : void {
			// remover listeners
		}
		/*
		* Move o scroll sem easing e dispara
		*/
		private function moveScroll(posY : Number) : void {
			// atualiza a posição do _contentScrollY (proporção)
			var evt : ScrollEvent = new ScrollEvent(ScrollEvent.MOVE);
			evt.percent = posY;
			dispatchEvent(evt);
		}
		/*
		* Move o scroll com easing e dispara
		*/
		/*private function moveEaseScroll(posY : Number) : void {
			// atualiza a posição do _contentScrollY (proporção)
			var evt : ScrollEvent = new ScrollEvent(ScrollEvent.MOVE_EASE);
			evt.percent = posY;
			dispatchEvent(evt);
		}*/
		/*
		* Inicia o scroll
		*/
		private function startScroll() : void {
			_enabled = true;
			// definir tamanho do bg e btnBar (proporção com o _contentMaxH)
			// mover o tamanho do btnBar para cima
			// criar o looper (?)
			btnUp.x = 0;
			btnUp.y = 0;
			
			bg.x = 0;
			bg.y = btnUp.height;
			bg.height = Math.round(_contentScrollH - (2 * btnUp.height));
			
			_bgH = bg.height;
			
			btnDw.x = 0;
			btnDw.y = bg.y + bg.height;
			
			btnBar.x = bg.x + 1;
			btnBar.y = bg.y;
			btnBar.setHeight(Math.round(_contentScrollH * bg.height / _contentMaxH));
			
			_barH = btnBar.height;
			
			btnUp.visible = true;
			btnDw.visible = true;
			btnBar.visible = true;
			bg.visible = true;
		}
		// GETTERS AND SETTERS 
		public function get scrollY() : Number {
			return _contentScrollY;
		}
	}
}