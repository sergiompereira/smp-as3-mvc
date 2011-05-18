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
	
	import com.smp.mvc.interfaces.IController;	
	import com.smp.mvc.interfaces.IModel;	
	import com.smp.mvc.interfaces.IView;
	import com.smp.mvc.core.CustomEvent;
	
	
	/**
	 * ABSTRACT CLASS
	 * 
	 * The Controller component of the MVC design pattern responds to user 
	 * inputs by modifying the Model. A controller listens too its view for 
	 * user inputs. If the data submitted by the view, affect the data 
	 * and logic, it will report that information up to the model. 
	 * Otherwise it should act directly back upon it's view ( i.e. onRollOver ).
	 *  
	 * A Controller has a direct relationship with its view and the model 
	 * the View represents. A Controller is generally only created by a View that 
	 * will accept user input, and in some cases the View won't have the need 
	 * for a Controller. If a view does not accept user input, and the default 
	 * controller method is called, a null controller will be returned.
	 * 
	 * @example
	 * <listing>
	 * 	import org.simplemvc.core.Controller;
	 * 	var ctrl:Controller = new Controller( model, view );
	 * </listing>
	 * 
	 * @see org.simplemvc.interfaces.IController;
	 * 
	 * @author Tony Birleffi
	 */
	public class AController implements IController
	{
		/** The reference to this controller's model. */
		protected var _model:IModel;
		
		protected var _view:IView;
	
	
		/**
		 * Create the controller for the mvc system.
		 * 
		 */
		public function AController()
		{
		
		}
		
		public function init(model:IModel, view:IView = null):void{
			_model = model;
			if(view!=null){
				_view = view;
			}
			registerEvents();
		}
		
		public function set model( model:IModel ):void
		{
			_model = model;
		}
		
		public function get model():IModel
		{
			return _model;
		}
		
		public function set view( view:IView ):void
		{
			_view = view;
		}
		
		public function get view():IView
		{
			return _view;
		}
		
		public function registerEvents():void {
			//Abstract
		}
		
		//Each controller should declare its own specific public methods in response to user input in specific views
		//These methods bellow, registered on the registerEvents function, are just immediate, though not robbust, solutions
		
		//Handling of all possible user input events
		public function mouseOverHandler(event:CustomEvent):void{}
		public function mouseOutHandler(event:CustomEvent):void{}
		public function mouseDownHandler(event:CustomEvent):void{}
		public function mouseUpHandler(event:CustomEvent):void{}
		public function mouseMoveHandler(event:CustomEvent):void{}
		public function mouseWheelHandler(event:CustomEvent):void{}
		
		public function keyboardUpHandler(event:CustomEvent):void{}
	}
}
