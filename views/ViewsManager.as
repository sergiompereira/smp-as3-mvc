package srg.mvc.views
{
 
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.display.DisplayObjectContainer;
		
	import srg.mvc.interfaces.IApplication;
	import srg.mvc.core.Application;
	import srg.mvc.core.CompositeView;
	
	import nl.demonsters.debugger.MonsterDebugger;
	
	public class  ViewsManager extends Application implements IApplication
	{
				
		protected var _viewsCollection:Array = new Array();
		protected var _activeView:CompositeView;
		protected var _activeViewIndex:String;
		protected var _container:DisplayObjectContainer;
	
		
		public function ViewsManager() {
			_container = this;
		}
		
		
		
		public function showView(id:int):void {


			if (_viewsCollection.length > 0){
				if(_activeView){
					handleHide();
				}
				handleShow(id);
			} 
			
			
		}
		
		protected function handleHide():void {
			(_activeView as CompositeView).hide();
			transitionOut();
		}
		
		
		
		protected function handleShow(id:int):void {
			
			transitionIn();
			_activeView = _viewsCollection[id];
			
			
			_container.addChild(_activeView);
			(_activeView as CompositeView).show();
			
		}
		
		
		
		
		protected function transitionIn():void {
			
		}
		
		protected function transitionOut():void {
			_container.removeChild(_activeView);
		}
		
	
	}
	
}