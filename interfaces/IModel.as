package srg.mvc.interfaces
{
	import flash.events.IEventDispatcher;
	
	
	/**
	 * public class  Model extends EventDispatcher implements IModel
	 */
	public interface  IModel extends IEventDispatcher
	{
		function setDataObject(object:Object):void;
		function clearDataObject():void;
	}
	
}