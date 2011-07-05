package br.com.cezinha.box {
	import br.com.stimuli.loading.BulkLoader;

	import com.greensock.TweenMax;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.utils.Timer;

	/**
	 * @author Celina Uemura (cezinha@cezinha.com.br)
	 */
	public class Image extends Sprite implements IBox {
		//  PUBLIC PROPERTIES -------------------------------------------------------------------------------------	
		//  PRIVATE PROPERTIES ------------------------------------------------------------------------------------
		private var _url : String;
		private var _loader : BulkLoader;
		private var _loaded : Boolean;	
		private var _isLoading : Boolean;
		private var _image : Bitmap;
		private var _delay : Number;
		private var _timer : Timer;
		private var _id : String;
		
		//  CONSTRUCTOR -------------------------------------------------------------------------------------------
		public function Image() {
			init();
		}

		public function load(url:String, loaderName:String = "main-loader"):void {						
			_url = url;
				
			try {
				_loader = BulkLoader.getLoader(loaderName);
			} catch (e:Error) {
				_loader = BulkLoader.createUniqueNamedLoader();
			}
			
			if (_loader == null) {
				_loader = BulkLoader.createUniqueNamedLoader();
			}
			
			if (!_loaded) {
				_loader.add(_url, {type:"image", id:_id});
				_loader.get(_id).addEventListener(Event.COMPLETE, onComplete, false, 0, true);
				_loader.get(_id).addEventListener(ProgressEvent.PROGRESS, onProgress, false, 0, true);
				_loader.start();
			}
		}

		//  PUBLIC METHODS ----------------------------------------------------------------------------------------
		public function show(delay:Number = 0):void {
			_delay = delay;
			_timer.start();
			
			if ((!_loaded) && (!_isLoading)) {
				_loader.loadNow(_id);
			} else {
				TweenMax.killTweensOf(this);
				TweenMax.to(this, 0.4, {autoAlpha:1, delay:delay});
			}
		}
		
		public function hide(delay:Number = 0):void {
			_delay = 0;
			_timer.stop();
			_timer.reset();
			
			TweenMax.killTweensOf(this);
			TweenMax.to(this, 0.4, {autoAlpha:0, delay:delay, onComplete:function():void {
				remove();
				dispatchEvent(new BoxEvent(BoxEvent.HIDE));
			}});
		}
		
		public function destroy():void {
			
		}
		
		public function remove():void {
			_loader.remove(_id);
			_loaded = false;
		}
		
		public function getBitmapData():BitmapData {
			return _image.bitmapData;
		}
		
		public function getBitmap():Bitmap {
			return _image;
		}
		
		//  PRIVATE METHODS ---------------------------------------------------------------------------------------
		private function init():void {
			this.alpha = 0;
			_isLoading = false;
			_timer = new Timer(1);
			_id = name;
		}
		
		//  EVENT HANDLERS ----------------------------------------------------------------------------------------	
		protected function onProgress(event:ProgressEvent):void {
			_isLoading = true;
			var porcento : Number = event.bytesLoaded / event.bytesTotal;
			
			var e : ImageEvent = new ImageEvent(ImageEvent.PROGRESS);
			e.porcento = porcento;
			
			dispatchEvent(e);
		}
		
		protected function onComplete(event:Event):void {
			_isLoading = false;
			_loader.get(_id).removeEventListener(Event.COMPLETE, onComplete);
			_loader.get(_id).removeEventListener(ProgressEvent.PROGRESS, onProgress);

			_image = _loader.getContent(_id) as Bitmap;
			_image.smoothing = true;
			addChild(_image);
			_loaded = true;
			
			TweenMax.killTweensOf(this);
			
			var delay : Number = 0;
			if (_timer.currentCount < (_delay * 1000)) {
				delay = ((_delay * 1000) - _timer.currentCount) / 1000;
			}
			
			_timer.stop();
			_timer.reset();
		
			TweenMax.to(this, 0.4, {autoAlpha:1, delay:_delay});
			
			var e : ImageEvent = new ImageEvent(ImageEvent.COMPLETE);
			e.loading = false;
			dispatchEvent(e);
		}

		//  GETTERS & SETTERS METHODS -----------------------------------------------------------------------------
	}
}