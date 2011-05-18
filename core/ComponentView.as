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

package  com.smp.mvc.core
{
	import flash.display.DisplayObject;
	import flash.events.Event;	
	import flash.utils.setTimeout;	
	import flash.display.MovieClip;
	
	import com.smp.mvc.interfaces.IModel;
	import com.smp.mvc.interfaces.IController;	
	import com.smp.mvc.interfaces.IView;
	
	/**
	 * The View component of the MVC design pattern is a distinct representation of a Model's data and or logic. 
	 * A view listens too and represents changes to the model for states of the application or logic. It is 
	 * recommended that the views in an MVC system be unaware of the inner workings of the system's 
	 * Model (ie. utilize a push only dispatching protocol in which the Model pushes information to 
	 * it's listeners through the event object). 
	 * 
	 * It is the responsibility of each view to make sure it has a controller. The controller can either be 
	 * passed in to the constructor or it will be automatically made by the view's. To create an MVC relationship; 
	 * a model is created and a view is created which is then added as a listener of its associated model. 
	 * The view primarily creates its own controller, but can use an existing one, this is not recommended. 
	 * It will be necessary to extend this View class and the core controller method in order to make more 
	 * specific view objects for specific view/controller pairings.
	 * 
	 * @example
	 * <listing>
	 * import org.simplemvc.core.View;
	 * var view:View = new View( model );
	 * </listing>
	 * 
	 * @author Tony Birleffi
	 */
	public class ComponentView extends Component implements IView
	{
		/** This view's model */
		protected var _model:IModel;
		
		/** The view's controller */
		protected var _controller:IController;
		
		protected var _target:DisplayObject;
		
		/**
		 * Create the view for the mvc system.
		 * Be aware that the superclass has already an update method, which can be used in response to specific events from the model
		 * 
		 * @param model				the model to associate with this view.
		 * @param controller		[Optional] the already created controller to associate with this view.
		 */
		public function ComponentView(){
			super();
		}
		
		
		public function init( model:IModel, controller:IController = null, target:DisplayObject = null)
		{
			// Save properties.
			_model = model;
			
			// If we have a controller set one.
			if ( controller != null ) _controller = controller;
			if ( target != null ) {
				_target = target; 
				addChild(_target);
			}
			
			// Register events.
			registerEvents();
		}

	
		/**
		 * ABSTRACE: override adding listeners to model and target
		 * Register events for the view.
		 */
		public function registerEvents():void
		{
			// Abstract.
		}
		
		
		/**
		 * The show method.
		 * 
		 * @param event		Event.
		 */
		public function show( event:Event = null):void
		{
			// Abstract.
		}
		
		/**
		 * The hide method.
		 * 
		 * @param event		Event.
		 */
		public function hide( event:Event = null):void
		{
			// Abstract.
		}
		
		
		/**
		 * Sets this view's model.
		 * 
		 * @param model		the model object.
		 */
		public function set model( model:IModel ):void
		{
			_model = model;
		}
		
		/**
		 * Gets this view's model.
		 * 
		 * @return Model.
		 */
		public function get model():IModel
		{
			return _model;
		}
		
		/**
		 * Sets the controller to associate with this view.
		 * 
		 * @param controller	IController class object.
		 */
		public function set controller( controller:IController ):void
		{
			_controller = controller;
		}
		
		/**
		 * Gets the view's controller instance.
		 * 
		 * @return IController.
		 */
		public function get controller():IController
		{
			return _controller;
		}
		
	
		public function set target( target:DisplayObject ):void
		{
			_target = target;
			addChild(_target);
		}
		
		public function get target():DisplayObject
		{
			return _target;
		}
	}
}
