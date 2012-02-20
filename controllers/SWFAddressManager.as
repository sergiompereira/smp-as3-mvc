package com.smp.mvc.controllers
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import com.asual.swfaddress.*;
	import com.smp.mvc.models.StateModel;
	
	
	public class  SWFAddressManager extends EventDispatcher
	{
		public var baseTitle:String = "";
		
		protected var _model:StateModel;
		protected var _init:Boolean = false;

		
		public function SWFAddressManager(){

			
		}
		
		public function init(model:StateModel):void {
			
			SWFAddress.addEventListener(SWFAddressEvent.CHANGE, onChange);
		
			//first load
			if (SWFAddress.getValue() != "/") {
				//ignored : automaticaly called on onChange...
				//changeContent(SWFAddress.getValue());
			}
			
			_model = model;
			_model.addEventListener(Event.CHANGE, onModelChanged);
			
		}
		
		protected function onChange(evt:SWFAddressEvent):void 
		{
			//debug:
			//SWFAddress.setTitle("onChange: swfaddress"+ evt.value.substring(1) +" model active:"+ _model.activeLabel);
			
			if (!_init) 
			{
				_init = true;
				
				/*
				 * Avoids calling a _model change on first load if the url is the root
				 * So it is left to the Main class to set the initial model state
				 * If the initial url is not the root, then SwfAddressManager will change the model 
				 * and override any default state previously set elsewhere in the application
				 */
				
				if (SWFAddress.getValue() != "/") {
					changeState(evt.value);
				}
				
			}
			else if (_model.state.stlevelId == -1)
			{
				//ignores any idle navigation if an url has been submited in the browser
				changeState(evt.value);
			}
			else
			{
				//this condition avoids a code loop ...
				if(evt.value.substring(1) != _model.activeLabel) {
					changeState(evt.value);
				}
			}
		}
		
		protected function changeState(value:String):void
		{	
			_model.setStateByLabel(value.substring(1));		
		}

		protected function onModelChanged(evt:Event):void 
		{			
			if (_model.state.stlevelId > -1)
			{
				SWFAddress.setValue(_model.activeLabel);
				
				if(SWFAddress.getValue() != "/"){
					SWFAddress.setTitle(baseTitle+ _model.activeTitle);
				}else{
					SWFAddress.setTitle(baseTitle);
				}
				
				//não é necessário invocar o google analytics. O próprio SWFAddress reconhece se o js existe na página.
				//navigateToURL(new URLRequest("javascript:pageTracker._trackPageview('"+evt+"'); void(0);"), "_self");
			}
		}
	}
	
}