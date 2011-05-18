package com.smp.mvc.models
{
	import flash.events.Event;
	import flash.errors.IOError;
	
	import com.smp.mvc.core.AModel;
		
	
	/**
	 * Singleton Class. Use getInstance instead of constructor
	 * 
	 * navData may be of type XMLList or Array. 
	 * In this last case, use an Array of objects, 
	 * where their properties would be the same as in the XMLList childnodes
	 * 
	 * Note: if a menu item has no contents (click through to the first submenu)
	 * define the optional <content> as "false"
	 * 
	 * * XMLList format:
	 * <root>
	 * 	<menu>
	 * 		<title>Prémios
	 * 		<label>premios
	 * 		<content>true
	 * 		<submenu>
	 * 			<title>Primeiros prémios
	 * 			<label>primeirospremios
	 * 		
	 * 		<submenu>
	 * 			...
	 * 
	 * * Array format:
	 * new Array(
	 * 			{label:"premios", title:"Prémios", content:"true", submenu:new Array(
	 * 					{label:"primeirospremios", title:"Primeiros prémios"},
	 * 					{label:"segundospremios", title:"Segundos prémios"}
	 * 				) 
	 * 			}, 
				{label:"participar", title:"Participar" }, 
				{label:"regulamento", title:"Regulamento" },
	 */
	
	 
	 /**
	  * Singleton...
	  */
	public class StateModel extends AModel 
	{
		
		protected var _stateObj:StateObject = new StateObject();
		
		private static var _instance:StateModel;
		
		
		public function StateModel(inst:PrivateClass) {
			super();
		}
		
		public static function getInstance():StateModel {
			if (StateModel._instance == null) {
				StateModel._instance = new StateModel(new PrivateClass());
			}
			return StateModel._instance;
		}
		
		
		public function getStLevelLength():Number
		{
			return getDataObject().length();
		}
		
		public function getNdLevelLength(state:StateObject):Number
		{
			if(getDataObject()[state.stlevelId].menu != null){
				return getDataObject()[state.stlevelId].menu.item.length();
			}
			
			return 0;
		}
		
		public function getRdLevelLength(state:StateObject):Number
		{
			if(getDataObject()[state.stlevelId].menu.item[state.ndlevelId].menu != null){
				return getDataObject()[state.stlevelId].menu.item[state.ndlevelId].menu.item.length();
			}
			
			return 0;
		}
		
		/**
		 * Returns a new StateObject instance, so the getter is not used to change state
		 * e.g. model.state.stlevelId = 1 doesn't change the inner state.
		 * In model.state.stlevelId, state is invoked as a getter.
		 */
		public function get state():StateObject {
		
			return new StateObject(_stateObj.stlevelId, _stateObj.ndlevelId, _stateObj.rdlevelId);
		}
		
		public function set state(value:StateObject):void {

			if (value.stlevelId != _stateObj.stlevelId || value.ndlevelId != _stateObj.ndlevelId  || value.rdlevelId != _stateObj.rdlevelId)
			{ 
				if (getDataObject()[value.stlevelId].content != null) {
					if (value.stlevelId > -1 && value.ndlevelId == -1 && getDataObject()[value.stlevelId].content == "false") {
						value.ndlevelId = 0;
					}
				}

				_stateObj = value;
				
				
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
		
		public function stateIs(state:StateObject, statecompare:StateObject = null):Boolean {
		
			if (statecompare == null) statecompare = _stateObj;
			if (statecompare.stlevelId != state.stlevelId) {
				return false;
			}else if (statecompare.ndlevelId != state.ndlevelId) {
				return false;
			}else if (statecompare.rdlevelId != state.rdlevelId) {
				return false;
			}else if (statecompare.thlevelId != state.thlevelId) {
				return false;
			}else {
				return true;
			}
			
			return false;
		}

		public function stateIsAscendent(state:StateObject, statecompare:StateObject = null):Boolean {
		
			if (statecompare == null) statecompare = _stateObj;
			if (statecompare.stlevelId != state.stlevelId) {
				return false;
			}else if (statecompare.ndlevelId != state.ndlevelId) {
				if (statecompare.ndlevelId != -1) {
					return false;
				}else{
					return true;
				}
			}else if (statecompare.rdlevelId != state.rdlevelId) {
				if (statecompare.rdlevelId != -1) {
					return false;
				}else{
					return true;
				}
			}else if (statecompare.thlevelId != state.thlevelId) {
				if (statecompare.thlevelId != -1) {
					return false;
				}else{
					return true;
				}
			}else {
				return true;
			}
			
			return false;
		}
		
		public function stateIsDescendent(state:StateObject, statecompare:StateObject = null):Boolean {
		
			if (statecompare == null) statecompare = _stateObj;
			if (statecompare.stlevelId != state.stlevelId) {
				return false;
			}else if (statecompare.ndlevelId != state.ndlevelId) {
				if (state.ndlevelId != -1) {
					return false;
				}else{
					return true;
				}
			}else if (statecompare.rdlevelId != state.rdlevelId) {
				if (state.rdlevelId != -1) {
					return false;
				}else{
					return true;
				}
			}else if (statecompare.thlevelId != state.thlevelId) {
				if (state.thlevelId != -1) {
					return false;
				}else{
					return true;
				}
			}else {
				return true;
			}
			
			return false;
		}

		
		public function getTitle(state:StateObject):String 
		{		
			if (state.ndlevelId == -1) {
				return getDataObject()[state.stlevelId].title;
			}else if (state.rdlevelId == -1) {
				return getDataObject()[state.stlevelId].menu.item[state.ndlevelId].title;
			}else{
				return getDataObject()[state.stlevelId].menu.item[state.ndlevelId].menu.item[state.rdlevelId].title;
			}
			
			return "";
		}
		
		public function getLabel(state:StateObject):String 
		{		
			if(state.ndlevelId == -1){
				return getDataObject()[state.stlevelId].label;
			}else if (state.rdlevelId == -1) {
				return getDataObject()[state.stlevelId].label+"/"+getDataObject()[state.stlevelId].menu.item[state.ndlevelId].label;
			}else{
				return getDataObject()[state.stlevelId].label+"/"+getDataObject()[state.stlevelId].menu.item[state.ndlevelId].label+"/"+getDataObject()[state.stlevelId].menu.item[state.ndlevelId].menu.item[state.rdlevelId].label;
			}
			
			return "";
		}
		
		public function get activeTitle():String 
		{						
			if (_stateObj.stlevelId > -1) 
			{		
				if(_stateObj.ndlevelId == -1){
					return getDataObject()[_stateObj.stlevelId].title;
				}else if(_stateObj.rdlevelId == -1){
					return getDataObject()[_stateObj.stlevelId].menu.item[_stateObj.ndlevelId].title;
				}else{
					return getDataObject()[_stateObj.stlevelId].menu.item[_stateObj.ndlevelId].menu.item[_stateObj.rdlevelId].title;
				}
			}else {
				handleInactiveState();
			}
			
			return "";
		}
		
		public function get activeLabel():String
		{
			if (_stateObj.stlevelId > -1)
			{		
				if(_stateObj.ndlevelId == -1){
					return getDataObject()[_stateObj.stlevelId].label;
				}else if(_stateObj.rdlevelId == -1){
					return getDataObject()[_stateObj.stlevelId].label+"/"+getDataObject()[_stateObj.stlevelId].menu.item[_stateObj.ndlevelId].label;
				}else{
					return getDataObject()[_stateObj.stlevelId].label+"/"+getDataObject()[_stateObj.stlevelId].menu.item[_stateObj.ndlevelId].label+"/"+getDataObject()[_stateObj.stlevelId].menu.item[_stateObj.ndlevelId].menu.item[_stateObj.rdlevelId].label;
				}
			}else {
				handleInactiveState();
			}
			
			return "";
		}
		
		public function get activeShortLabel():String 
		{
			if (_stateObj.stlevelId > -1)
			{
				if(_stateObj.ndlevelId == -1){
					return getDataObject()[_stateObj.stlevelId].label;
				}else if(_stateObj.rdlevelId == -1){
					return getDataObject()[_stateObj.stlevelId].menu.item[_stateObj.ndlevelId].label;
				}else{
					return getDataObject()[_stateObj.stlevelId].menu.item[_stateObj.ndlevelId].menu.item[_stateObj.rdlevelId].label;
				}
			}else {
				handleInactiveState();
			}
			
			return "";
		}
		
		public function getStateByLabel(label:String):StateObject {
						
			var stlevelLength:Number;
			var ndlevelLength:Number;
			var rdlevelLength:Number;
			var state:StateObject = new StateObject();
			
			var labels:Array = label.split("/");
			
			stlevelLength = getDataObject().length();
			
					
					
				
			for (var i:int = 0; i < stlevelLength; i++) 
			{
				if (getDataObject()[i].label == labels[0]) 
				{
					state.stlevelId = i;
					
					if (labels.length > 1) 
					{
						ndlevelLength = getDataObject()[i].menu.item.length();
						
						for (var j:int = 0; j < ndlevelLength; j++) 
						{
							if (getDataObject()[i].menu.item[j].label == labels[1]) 
							{
								state.ndlevelId = j;
								
								if (labels.length > 2) 
								{
									rdlevelLength = getDataObject()[i].menu.item[j].menu.item.length();
									
									for (var k:int = 0; k < rdlevelLength; k++) 
									{
										if (getDataObject()[i].menu.item[j].menu.item[k].label == labels[2]) 
										{
											state.rdlevelId = k;
											break;
										}
										
									}
								}
								break;
							}
							
						}
					}
					
					break;
				}
			}
			
			return state;
			
		}
		
		public function setStateByLabel(label:String):void {
			
			var state:StateObject = getStateByLabel(label);
			
			if (state.stlevelId > -1) {
				this.state = state;
			}else {
				//default
				this.state = new StateObject(0);
			}
			
		}
	
		
		public function hasContent(value:StateObject):Boolean {
			
			if (state.ndlevelId == -1) {
				if(getDataObject()[state.stlevelId].@content == "true"  || getDataObject()[state.stlevelId].@content == undefined) return true;
			}else if (state.rdlevelId == -1) {
				if(getDataObject()[state.stlevelId].menu.item[state.ndlevelId].@content == "true"  || getDataObject()[state.stlevelId].menu.item[state.ndlevelId].@content == undefined) return true;
			}else {
				if(getDataObject()[state.stlevelId].menu.item[state.ndlevelId].menu.item[state.rdlevelId].@content == "true"  || getDataObject()[state.stlevelId].menu.item[state.ndlevelId].menu.item[state.rdlevelId].@content == undefined) return true;
			}
			
			return false;
		
		}
		
		private function handleInactiveState():void {
			//throw new IOError("NavigationModel : State is set to none. Navigation should be inactive.");
		}
	}
	
}


class PrivateClass {
	public function PrivateClass() {
		//
	}
}