package com.smp.mvc.core
{
	import flash.events.Event;
	
	public class  CustomEvent extends Event
	{
		/**
		 * Define your own public static constants for custom events
		 */
		
		protected var _data:Object;
		
		public function CustomEvent(type:String, data:Object = null,  bubbles:Boolean = false, cancelable:Boolean = false) {
			_data = data;
			super(type, bubbles, cancelable);
		}
		
		public function get data():Object {
			return _data;
		}
	}
	
}