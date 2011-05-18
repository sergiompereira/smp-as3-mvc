package com.smp.mvc.models
{
	
	
	public class  StateObject
	{
		public var stlevelId:int;
		public var ndlevelId:int;
		public var rdlevelId:int;
		public var thlevelId:int;
		
		public function StateObject(stlevelId:int = -1, ndlevelId:int = -1, rdlevelId:int = -1, thlevelId:int = -1)
		{
			this.stlevelId = stlevelId;
			this.ndlevelId = ndlevelId;
			this.rdlevelId = rdlevelId;
			this.thlevelId = thlevelId;
		}
		
		public function clone():StateObject {
			return new StateObject(this.stlevelId, this.ndlevelId, this.rdlevelId, this.thlevelId);
		}
		
	}
	
}