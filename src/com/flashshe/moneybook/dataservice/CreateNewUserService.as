package com.flashshe.moneybook.dataservice
{
	import com.flashshe.moneybook.domain.ICreateNewUser;
	
	import flash.data.SQLConnection;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	import flash.net.Responder;
	
	import mx.rpc.IResponder;
	
	/**
	 * 创建新用户服务
	 */
	public class CreateNewUserService implements ICreateNewUser
	{
		public function CreateNewUserService()
		{
		}
		
		public function createNewUser(userName:String):void
		{
			var conn:SQLConnection = new SQLConnection();
			conn.addEventListener(SQLEvent.OPEN, openHandler);
			conn.addEventListener(SQLErrorEvent.ERROR, errorHandler);
			var folder:File = File.applicationStorageDirectory;
			var dbFile:File = folder.resolvePath("moneybook.db");
			conn.openAsync(dbFile);
		}
		
		/**
		 * @inheritDoc
		 */
		public function openHandler(event:SQLEvent):void
		{
			
		}
		
		/**
		 * @inheritDoc
		 */
		public function errorHandler(event:SQLErrorEvent):void
		{
			
		}
	}
}