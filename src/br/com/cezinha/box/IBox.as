package br.com.cezinha.box {

	/**
	 * @author Celina Uemura (cezinha@cezinha.com.br)
	 */
	public interface IBox {
		function show(delay:Number = 0):void;
		function hide(delay:Number = 0):void;		
		function destroy():void;
	}
}
