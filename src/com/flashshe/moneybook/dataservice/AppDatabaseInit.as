package com.flashshe.moneybook.dataservice
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	
	/**
	 * 应用程序数据库初始化完成后派发该事件
	 */
	[Event(name="databaseInitCompleted", type="flash.events.Event")]
	
	/**
	 * 负责初始化应用程序数据库
	 */
	public class AppDatabaseInit extends EventDispatcher
	{
		public static const INIT_COMPLETED:String = "databaseInitCompleted";
		
		private var dbConn:DBConnection;
		
		public function AppDatabaseInit()
		{
			super(null);
			dbConn = DBConnection.getInstance();
		}
		
		/**
		 * <code>true</code>表示应用程序数据库已经初始化，否则表示没有
		 */
		public function get initialized():Boolean
		{						
			var folder:File = File.applicationStorageDirectory;
			var dbFile:File = folder.resolvePath(dbConn.appDbName);
			
			return dbFile.exists;
		}		
		
		/**
		 * 执行数据库初始化
		 */
		public function init():void
		{
			if (!initialized)
			{
				var appfolder:File = File.applicationDirectory;
				var dbTempleteFile:File = appfolder.resolvePath("db/" + dbConn.appDbName);
				
				var appStoragefolder:File = File.applicationStorageDirectory;
				var dbFile:File = appStoragefolder.resolvePath(dbConn.appDbName);
				
				dbTempleteFile.copyTo(dbFile, true);
			}
			
			dispatchEvent(new Event(INIT_COMPLETED));
		}
	}
}