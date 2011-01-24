package com.flashshe.moneybook.dataservice
{
	import com.flashshe.moneybook.domain.ICreateNewUser;
	
	import flash.data.SQLConnection;
	
	/**
	 * 创建新用户服务
	 */
	public class CreateNewUserService implements ICreateNewUser
	{
		private var conn:SQLConnection;
		private var appDatabaseInit:AppDatabaseInit;
		private var userName:String;
		
		public function CreateNewUserService()
		{
			appDatabaseInit = new AppDatabaseInit();
		}
		
		public function createNewUser(userName:String):void
		{
			this.userName = userName;
			if (appDatabaseInit.initialized)
			{
				
			}
			else
			{
				appDatabaseInit.init();
			}
		}
	}
}