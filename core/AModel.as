//////////////////////////////////////////////////////////////////////////////////
//
// AS3-SimpleMVC - Copyright (c) 2008 Tony Birleffi
//
// Permission is hereby granted, free of charge, to any person
// obtaining a copy of this software and associated documentation
// files (the "Software"), to deal in the Software without
// restriction, including without limitation the rights to use,
// copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
// OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.
//
//////////////////////////////////////////////////////////////////////////////////

package com.smp.mvc.core
{
	import flash.errors.IllegalOperationError;
	import flash.events.Event;		
	import flash.events.EventDispatcher;
		
	import com.smp.mvc.interfaces.IModel;
	import com.smp.mvc.core.CustomEvent;
		
	/**
	 * ABSTRACT CLASS
	 * 
	 * The Model component of the MVC design pattern handles and stores the 
	 * data and application logic for the interface. It is recommended that 
	 * the Model utilize a push only dispatching protocol in which it dispatches 
	 * information to it's listeners through the event object. This happens without 
	 * any knowledge of who or what is listening. It is recommended that this class 
	 * is sub classed in order to communicate and manage application logic, however 
	 * you can use it directly as well.
	 * 
	 * @example
	 * <listing>
	 * import org.simplemvc.core.Model;
	 * var model:Model = new Model( data );
	 * model.addEventListener( Model.ALL_EVENTS, handler );
	 * </listing>
	 * 
	 * @see flash.events.EventDispatcher;
	 * 
	 * @author Tony Birleffi
	 */
	public class AModel extends EventDispatcher implements IModel
	{
		/** Event name for all events. */
		public static const ALL_EVENTS:String = "onAllEvents";
		public static const CLEAR:String = "_destroy";
		
		/** The data. */
		protected var modelData:Object = null;
		
		/** The current event. */
		protected var cEvent:String = "";
	
		
		/**
		 * Constructor.
		 * 
		 * @param data		data array of objects, or xml or whatever object.
		 */
		public function AModel()
		{
			super();
		}
		
		/**
		 * Updates the current application view by event and removes the previous.
		 * 
		 * @param event		event string id.
		 */
		public function updateLocation( event:String ):void
		{
			// If no events defined yet, then send out the first event.
			if( cEvent.length == 0 ) 
			{
				cEvent = event;
				dispatchEvent( new CustomEvent( event ) );
			}
			else
			{
				// Run the event to destroy the current event.
				dispatchEvent( new CustomEvent( ( cEvent + CLEAR ) ) );
				
				// Then send out the new event and make that the current event.
				cEvent = event;
			}
			
			// Send out an all events request.
			dispatchEvent( new CustomEvent( ALL_EVENTS ) );
		}
		
		/**
		 * Method used for just sending internal events for the application,
		 * doesn't update the current id like 'updateLocation' does.
		 * 
		 * @param event		string id.
		 */
		public function sendInternalEvent( event:String ):void
		{
			dispatchEvent( new CustomEvent( event ) );
		}
		
		/**
		 * Sets the current model data.
		 * 
		 * @param data		value.
		 */
		public function setDataObject( data:Object ):void
		{
			modelData = data;
		}
		
		/**
		 * Gets the current model data.
		 * 
		 * @return *.
		 */
		public function getDataObject():Object
		{
			return modelData;
		}
		
		
			/**
		 * Clears the current model data.
		 */
		public function clearDataObject():void
		{
			modelData = null;
		}
		
		/**
		 * Gets the current event.
		 * 
		 * @return String.
		 */
		public function get currentEvent():String
		{
			return cEvent;
		}
	}
}
