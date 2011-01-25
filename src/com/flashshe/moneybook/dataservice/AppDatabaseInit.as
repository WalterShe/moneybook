package com.flashshe.moneybook.dataservice
{
	import flash.data.SQLConnection;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	
	[Event(name="initCompleted", type="flash.events.Event")]
	
	/**
	 * 负责初始化应用程序必须的数据库
	 */
	public class AppDatabaseInit extends EventDispatcher
	{
		private var conn:SQLConnection;
		private var dao:DBConnection;
		
		public function AppDatabaseInit()
		{
			super(null);
			dao = DBConnection.getInstance();
		}
		
		/**
		 * <code>true</code>表示应用程序的必须数据库已经建立好，否则表示没有
		 */
		public function get initialized():Boolean
		{						
			var folder:File = File.applicationStorageDirectory;
			var dbFile:File = folder.resolvePath(dao.appDbName);
			
			return dbFile.exists;
		}		
		
		/**
		 * 建立应用程序必须的数据库
		 */
		public function init():void
		{
			if (!initialized)
			{
				var appfolder:File = File.applicationDirectory;
				var dbTempleteFile:File = appfolder.resolvePath("db/" + dao.appDbName);
				
				var appStoragefolder:File = File.applicationStorageDirectory;
				var dbFile:File = appStoragefolder.resolvePath(dao.appDbName);
				
				dbTempleteFile.copyTo(dbFile, true);
				dispatchEvent(new Event("initCompleted"));
			}
		}
	}
}